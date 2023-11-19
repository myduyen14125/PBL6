import { HttpException, HttpStatus, Injectable, forwardRef, Inject } from '@nestjs/common';
import { UserRepository } from './user.repository';
import { CreateUserDto, LoginUserDto, UpdateUserDto } from './dto/user.dto';
import * as bcrypt from 'bcrypt';
import { User } from './user.model';
import { BlogService } from 'src/blog/blog.service';
import { ScheduleService } from 'src/schedule/schedule.service';
import { RatingService } from 'src/rating/rating.service';
import { BioService } from 'src/bio/services/bio.service';
import { MediaService } from 'src/media/media.service';
import { MailerService } from '@nestjs-modules/mailer';
import { UpdatePasswordDto } from './dto/password.dto';
import { CourseService } from 'src/course/services/course.service';

@Injectable()
export class UserService {
    constructor(
        private readonly userRepository: UserRepository,
        @Inject(forwardRef(() => BlogService)) private readonly blogService: BlogService,
        @Inject(forwardRef(() => ScheduleService)) private readonly scheduleService: ScheduleService,
        @Inject(forwardRef(() => RatingService)) private readonly ratingService: RatingService,
        @Inject(forwardRef(() => BioService)) private readonly bioService: BioService,
        @Inject(forwardRef(() => MediaService)) private readonly mediaService: MediaService,
        @Inject(forwardRef(() => CourseService)) private readonly courseService: CourseService,
        private mailerService: MailerService
    ) { }

    async createUser(userDto: CreateUserDto) {

        // Check if user already existed
        const userInDb = await this.userRepository.findByCondition({email: userDto.email})

        if (userInDb) {throw new HttpException('User already exists', HttpStatus.BAD_REQUEST);}

        // Handle pre-creation
        if (!userDto.avatar) userDto.avatar = ""
        userDto.password = await bcrypt.hash(userDto.password, 10);

        const newUser = await this.userRepository.create(userDto)

        // Create empty bio
        await this.bioService.createBio(newUser)

        // Send registration email
        await this.mailerService.sendMail({
            to: userDto.email,
            subject: 'Welcome to IT-Mentor Community!',
            template: `./register`,
            context: {
                name: userDto.name
            }
        })

        return newUser
    }

    async login({ email, password }: LoginUserDto) {
        const user = await this.userRepository.findByCondition({
            email: email,
        })
        if (!user) {throw new HttpException('User not found', HttpStatus.UNAUTHORIZED);}
        if (!bcrypt.compareSync(password, user.password)) {throw new HttpException('Invalid credentials', HttpStatus.UNAUTHORIZED);}
        return user;
    }

    async updateUserRefreshToken(filter, update) {
        if (update.refreshToken) {
            update.refreshToken = await bcrypt.hash(
                this.reverse(update.refreshToken),
                10,
            );
        }
        return await this.userRepository.findByConditionAndUpdate(filter, update);
    }

    async updateUserInfo(user: User, userDto: UpdateUserDto) {
        if (user.role === 'mentee') {
            delete userDto.expertise;
        }
        // Remove avatar field (already has a different route)
        delete userDto.avatar;
        return (await this.userRepository.findByIdAndUpdate(user.id, userDto)).populate({ path: 'expertise', select: 'name' });
    }

    private reverse(s) {
        return s.split('').reverse().join('');
    }

    async findByEmail(email) {
        return await this.userRepository.findByCondition({
            email: email,
        });
    }

    async getUserById(id: string) {
        const user = await this.userRepository.findById(id, ['-password', '-refreshToken', '-date_of_birth', '-skype_link', '-facebook_link']);
        if (!user) throw new HttpException('User does not exist', HttpStatus.NOT_FOUND);
        await user.populate(
            [
                { path: 'expertise', select: 'name' },
                { 
                    path: 'bio',
                    select: '-user awards skills educations experiences',
                    populate: {
                        path: 'awards skills educations experiences',
                    },
                }
            ]
        )
        return user.toObject()
    }

    async getProfile(user: User) {
        const returnUser = await this.userRepository.findById(user.id);
        await returnUser.populate(
            [
                { path: 'expertise', select: 'name' },
                { 
                    path: 'bio',
                    select: '-user awards skills educations experiences',
                    populate: {
                        path: 'awards skills educations experiences',
                    },
                }
            ]
        )
        return returnUser.toObject()
    }

    async getAllMentors(page: number, limit: number = 10) {
        const count = await this.userRepository.countDocuments({ role: 'mentor' })
        const countPage = Math.ceil(count / limit)
        const mentors = await this.userRepository.getByCondition(
            { role: 'mentor' },
            ['name', 'avatar', 'email', 'number_of_mentees'],
            {
                sort: {
                    _id: -1,
                },
                skip: (page - 1) * limit,
                limit: limit
            },
            { path: 'expertise', select: 'name' },
        );

        return { count, countPage, mentors }
    }

    async searchMentor(name: string, expertise: string, page: number, limit: number = 10) {
        let query: { role: string; name?: { $regex: RegExp }; expertise?: string } = {
            role: 'mentor'
        };

        if (name) { query.name = { $regex: new RegExp(name, 'i') };}
        if (expertise) {query.expertise = expertise; }

        const count = await this.userRepository.countDocuments(query)
        const countPage = Math.ceil(count / limit)

        const mentors = await this.userRepository.getByCondition(
            query,
            ['name', 'avatar', 'email', 'number_of_mentees'],
            {
                sort: {
                    _id: -1,
                },
                skip: (page - 1) * limit,
                limit: limit
            },
            { path: 'expertise', select: 'name' }
        );

        return { count, countPage, mentors }
    }

    async updateUserNumberOfMentees(id: string) {
        return await this.userRepository.findByIdAndUpdate(id, { $inc: { number_of_mentees: 1 } });
    }

    async getAllBlogsByUserId(id: string, page: number, limit: number) {
        return await this.blogService.getAllBlogsByUserId(id, page, limit)
    }

    async getAllSchedulesByUserId(id: string) {
        return await this.scheduleService.getAllSchedulesByUserId(id)
    }

    async getAllCoursesByCreatorId(id: string, page: number, limit: number = 10) {
        const user = await this.userRepository.findById(id)
        if (user.role === "mentee") return
        return await this.courseService.getAllCoursesByCreatorId(id, page, limit)
    }

    async getAllRatingsByUserId(id: string, page: number, limit: number) {
        return await this.ratingService.getAllRatingsByUserId(id, page, limit)
    }

    async getUserByRefresh(refresh_token, email) {
        const user = await this.findByEmail(email);
        if (!user) {
            throw new HttpException('Invalid token', HttpStatus.UNAUTHORIZED);
        }
        const is_equal = await bcrypt.compare(
            this.reverse(refresh_token),
            user.refreshToken,
        );

        if (!is_equal) {
            throw new HttpException('Invalid credentials', HttpStatus.UNAUTHORIZED);
        }

        return user;
    }

    async updateAvatar(user: User, file) {
        const avatar = await this.mediaService.upload(file)
        return await this.userRepository.findByIdAndUpdate(user.id, {avatar: avatar.url})
    }

    async changePassword(user: User, passwordDto: UpdatePasswordDto) {
        if (!bcrypt.compareSync(passwordDto.old_password, user.password)) {
            throw new HttpException('Wrong old password', HttpStatus.BAD_REQUEST);
        }

        if (passwordDto.old_password === passwordDto.new_password) {
            throw new HttpException('New password cant be the same as old password', HttpStatus.BAD_REQUEST);
        }
        const newPassword = await bcrypt.hash(passwordDto.new_password, 10);

        return await this.userRepository.findByIdAndUpdate(user.id, {
            password: newPassword
        })
    }

    async forgotPassword(email: string) {
        const userCheck = await this.userRepository.findByCondition({ email: email })
        if (!userCheck) throw new HttpException('No such email exists', HttpStatus.BAD_REQUEST);

        const newPassword = this.generateRandomPassword(10);
        const newPasswordHashed = await bcrypt.hash(newPassword, 10);
        await this.userRepository.findByIdAndUpdate(userCheck.id, { password: newPasswordHashed })

        // await this.mailerService.sendMail({
        //     to: email,
        //     subject: 'Your new password',
        //     template: `./forgotpassword`,
        //     context: {
        //         password: newPassword
        //     }
        // })

        return "check your email for new password"

    }

    generateRandomPassword(length: number): string {
        const charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        let password = "";
        for (let i = 0; i < length; i++) {
            const randomIndex = Math.floor(Math.random() * charset.length);
            password += charset.charAt(randomIndex);
        }
        return password;
    }

    async checkMentee(mentee_id: string) {
        const mentor = await this.userRepository.findById(mentee_id);
        if (mentor && mentor.role == "mentee") {
            return true
        }
        return false
    }

    async checkMentor(mentor_id: string) {
        const mentor = await this.userRepository.findById(mentor_id);
        if (mentor && mentor.role == "mentor") {
            return true
        }
        return false
    }
}
