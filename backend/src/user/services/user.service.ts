import { HttpException, HttpStatus, Injectable, forwardRef, Inject } from '@nestjs/common';
import { UserRepository } from '../repositories/user.repository';
import { CreateUserDto, LoginUserDto, UpdateUserDto } from '../dto/user.dto';
import * as bcrypt from 'bcrypt';
import { User } from '../models/user.model';
import { BlogService } from 'src/blog/services/blog.service';
import { ScheduleService } from 'src/schedule/services/schedule.service';
import { RatingService } from 'src/rating/services/rating.service';
import { BioService } from 'src/bio/services/bio.service';
import { MediaService } from 'src/media/services/media.service';
import { MailerService } from '@nestjs-modules/mailer';

@Injectable()
export class UserService {
    constructor(
        private readonly userRepository: UserRepository,
        @Inject(forwardRef(() => BlogService)) private readonly blogService: BlogService,
        @Inject(forwardRef(() => ScheduleService)) private readonly scheduleService: ScheduleService,
        @Inject(forwardRef(() => RatingService)) private readonly ratingService: RatingService,
        @Inject(forwardRef(() => BioService)) private readonly bioService: BioService,
        @Inject(forwardRef(() => MediaService)) private readonly mediaService: MediaService,
        private mailerService: MailerService


    ) { }



    async createUser(userDto: CreateUserDto) {

        // Check if user already existed
        const userInDb = await this.userRepository.findByCondition({
            email: userDto.email
        })

        if (userInDb) {
            throw new HttpException('User already exists', HttpStatus.BAD_REQUEST);
        }

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

        if (!user) {
            throw new HttpException('User not found', HttpStatus.UNAUTHORIZED);
        }

        if (!bcrypt.compareSync(password, user.password)) {
            throw new HttpException('Invalid credentials', HttpStatus.UNAUTHORIZED);
        }

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
        // Remove expertise for mentee 
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
        const user = await this.userRepository.findById(id);
        if (!user) throw new HttpException('User does not exist', HttpStatus.NOT_FOUND);
        await user.populate({ path: 'expertise', select: 'name' })
        const userObject = user.toObject ? user.toObject() : user;
        delete userObject.password;
        delete userObject.refreshToken;
        const bio = await this.bioService.getUserBio(user.id)
        const result = {
            ...userObject,
            bio: bio
        };
        return result
    }

    async getProfile(user: User) {

        const returnUser = await this.userRepository.findById(user.id);
        await returnUser.populate({ path: 'expertise', select: 'name' })
        const bio = await this.bioService.getUserBio(user.id)
        const userData = returnUser.toObject();
        const result = {
            ...userData,
            bio: bio
        };
        return result
    }

    async getAllMentors(page: number, limit: number = 10) {
        const count = await this.userRepository.countDocuments({ role: 'mentor' })
        const countPage = Math.ceil(count / limit)
        const mentors = await this.userRepository.getByCondition(
            { role: 'mentor' },
            ['name', 'avatar', 'email', 'gender', 'phone', 'number_of_mentees'],
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

    async searchMentor(keyword: string, keyword2: string, page: number, limit: number = 10) {
        let query: { role: string; name?: { $regex: RegExp }; expertise?: string } = {
            role: 'mentor'
        };

        if (keyword) {
            query.name = { $regex: new RegExp(keyword, 'i') };
        }

        if (keyword2) {
            query.expertise = keyword2;
        }

        const count = await this.userRepository.countDocuments(query)
        const countPage = Math.ceil(count / limit)

        const mentors = await this.userRepository.getByCondition(
            query,
            ['name', 'avatar', 'email', 'gender', 'phone', 'number_of_mentees'],
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

    async updateUserNumberOfMentees(id: string) {
        return await this.userRepository.findByIdAndUpdate(id, { $inc: { number_of_mentees: 1 } });
    }

    async getAllBlogsByUserId(id: string, page: number, limit: number) {
        return await this.blogService.getAllBlogsByUserId(id, page, limit)
    }

    async getAllSchedulesByUserId(id: string) {
        return await this.scheduleService.getAllSchedulesByUserId(id)
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
        return await this.userRepository.findByIdAndUpdate(user.id, {
            avatar: avatar.url
        })
    }

    async changePassword(user: User, password: string) {
        const newPassword = await bcrypt.hash(password, 10);

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

        await this.mailerService.sendMail({
            to: email,
            subject: 'Your new password',
            template: `./forgotpassword`,
            context: {
                password: newPassword
            }
        })

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

    // async forgotPassword(email: string) {
    //     const userCheck = await this.userRepository.findByCondition({ email: email })
    //     if (!userCheck) throw new HttpException('No such email exists', HttpStatus.BAD_REQUEST);

    //     var tokenModel = await this.createPasswordToken(email)
    //     if (tokenModel && tokenModel.token) {
    //         await this.mailerService.sendMail({
    //             to: email,
    //             subject: 'Click here to reset your password',
    //             template: `./forgotpassword`,
    //             context: {
    //                 token: tokenModel.token
    //             }
    //         })
    //     }

    // }

    // async createPasswordToken(email: string) {
    //     const forgottenPassword = await this.forgotPasswordModel.findOne({ email: email })

    //     if (forgottenPassword && (new Date().getTime() - forgottenPassword.timestamp.getTime()) / 60000 < 15) {
    //         throw new HttpException('Reset password email has already been sent recently', HttpStatus.BAD_REQUEST);
    //     }
    //     var fp = await this.forgotPasswordModel.findOneAndUpdate(
    //         { email: email },
    //         {
    //             email: email,
    //             token: (Math.floor(Math.random() * 9000000) + 1000000).toString(),
    //             timestamp: new Date()
    //         },
    //         { upsert: true, new: true }
    //     )
    //     if (fp) {
    //         return fp
    //     }
    // }


}
