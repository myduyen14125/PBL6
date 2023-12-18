import { MailerService } from '@nestjs-modules/mailer';
import { HttpException, HttpStatus, Inject, Injectable, forwardRef } from '@nestjs/common';
import * as bcrypt from 'bcrypt';
import { BioService } from 'src/bio/services/bio.service';
import { MediaService } from 'src/media/media.service';
import { UpdatePasswordDto } from './dto/password.dto';
import { CreateUserDto, LoginUserDto, UpdateUserDto } from './dto/user.dto';
import { User } from './user.model';
import { UserRepository } from './user.repository';

@Injectable()
export class UserService {
    constructor(
        private readonly userRepository: UserRepository,
        @Inject(forwardRef(() => BioService)) private readonly bioService: BioService,
        @Inject(forwardRef(() => MediaService)) private readonly mediaService: MediaService,
        private mailerService: MailerService
    ) { }

    async createUser(dto: CreateUserDto) {
        // Check if user already existed
        const userInDb = await this.userRepository.findByCondition({email: dto.email})
        if (userInDb) {throw new HttpException('User already exists', HttpStatus.BAD_REQUEST);}

        // Handle pre-creation
        if (!dto.avatar) dto.avatar = ""
        dto.password = await bcrypt.hash(dto.password, 10);
        const newUser = await this.userRepository.create(dto)

        // Create empty bio
        await this.bioService.createBio(newUser)

        // Send registration email
        await this.mailerService.sendMail({
            to: dto.email,
            subject: 'Welcome to IT-Mentor Community!',
            template: `./register`,
            context: {
                name: dto.name
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

    async updateUserInfo(user: User, dto: UpdateUserDto) {
        // Remove expertise from mentee, Comment if unnecessary
        if (user.role === 'mentee') {
            delete dto.expertise;
        }
        return (await this.userRepository.findByIdAndUpdate(user.id, dto)).populate({ path: 'expertise', select: 'name' });
    }

    private reverse(s) {
        return s.split('').reverse().join('');
    }

    async findByEmail(email) {
        return await this.userRepository.findByCondition({email: email});
    }

    async getUserById(id: string) {
        // Hide private fields
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
                    name: 1,
                },
                skip: (page - 1) * limit,
                limit: limit
            },
            { path: 'expertise', select: 'name' },
        );

        return { count, countPage, mentors }
    }

    async searchMentor(name: string, expertise: string, page: number, limit: number = 10) {
        let query: { role: string; name?: { $regex: RegExp }; expertise?: string } = { role: 'mentor'};

        if (name) { query.name = { $regex: new RegExp(name, 'i') };}
        if (expertise) {query.expertise = expertise; }

        const count = await this.userRepository.countDocuments(query)
        const countPage = Math.ceil(count / limit)

        const mentors = await this.userRepository.getByCondition(
            query,
            ['name', 'avatar', 'email', 'number_of_mentees', 'phone', 'gender'],
            {
                sort: {
                    name: 1,
                },
                skip: (page - 1) * limit,
                limit: limit
            },
            { path: 'expertise', select: 'name' }
        );

        return { count, countPage, mentors }
    }

    async updateUserNumberOfMentees(id: string) {
        // Increase by one upon finishing an appointment
        return await this.userRepository.findByIdAndUpdate(id, { $inc: { number_of_mentees: 1 } });
    }

    async getUserByRefresh(refresh_token, email) {
        const user = await this.findByEmail(email);
        if (!user) throw new HttpException('Invalid token', HttpStatus.UNAUTHORIZED);

        const isEqual = await bcrypt.compare(
            this.reverse(refresh_token),
            user.refreshToken,
        );
        if (!isEqual) throw new HttpException('Invalid credentials', HttpStatus.UNAUTHORIZED);

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
        // const userCheck = await this.userRepository.findByCondition({ email: email })
        const user = await this.findByEmail(email)
        if (!user) throw new HttpException('No such email exists', HttpStatus.BAD_REQUEST);

        const newPassword = this.generateRandomPassword(10);
        const newPasswordHashed = await bcrypt.hash(newPassword, 10);
        await this.userRepository.findByIdAndUpdate(user.id, { password: newPasswordHashed })

        await this.mailerService.sendMail({
            to: email,
            subject: 'Your new password',
            template: `./forgotpassword`,
            context: {
                password: newPassword
            }
        })

        return "Email sent"

    }

    generateRandomPassword(length: number): string {
        const charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        const specialCharacters = "!@#$%&*";
        // Ensure at least one special character
        const randomSpecialChar = specialCharacters.charAt(Math.floor(Math.random() * specialCharacters.length));
        // Ensure at least one capital letter
        const randomCapitalLetter = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".charAt(Math.floor(Math.random() * 26));
        // Generate the remaining part of the password
        const remainingLength = length - 2; // 1 for special char, 1 for capital letter
        let password = "";
        for (let i = 0; i < remainingLength; i++) {
            const randomIndex = Math.floor(Math.random() * charset.length);
            password += charset.charAt(randomIndex);
        }
        // Insert the special character and capital letter at random positions
        const randomPosition1 = Math.floor(Math.random() * (length - 1)); // position for special char
        const randomPosition2 = Math.floor(Math.random() * length); // position for capital letter
      
        password =
            password.slice(0, randomPosition1) +
            randomSpecialChar +
            password.slice(randomPosition1, randomPosition2) +
            randomCapitalLetter +
            password.slice(randomPosition2);
      
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

    // Admin access
    async getAllMentees(page: number, limit: number = 10) {
        const count = await this.userRepository.countDocuments({ role: 'mentee' })
        const countPage = Math.ceil(count / limit)
        const mentees = await this.userRepository.getByCondition(
            { role: 'mentee' },
            ['name', 'avatar', 'email', 'date_of_birth', 'gender', 'facebook_link', 'skype_link', 'phone'],
            {
                sort: {
                    name: 1,
                },
                skip: (page - 1) * limit,
                limit: limit
            },
        );

        return { count, countPage, mentees }
    }

    async searchMentee(name: string, page: number, limit: number = 10) {
        let query: { role: string; name?: { $regex: RegExp };} = {
            role: 'mentee'
        };

        if (name) { query.name = { $regex: new RegExp(name, 'i') };}

        const count = await this.userRepository.countDocuments(query)
        const countPage = Math.ceil(count / limit)

        const mentees = await this.userRepository.getByCondition(
            query,
            ['name', 'avatar', 'email', 'date_of_birth', 'gender', 'facebook_link', 'skype_link', 'phone'],
            {
                sort: {
                    name: 1,
                },
                skip: (page - 1) * limit,
                limit: limit
            },
        );

        return { count, countPage, mentees }
    }
}
