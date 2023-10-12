import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { UserRepository } from '../repositories/user.repository';
import { CreateUserDto, LoginUserDto } from '../dto/user.dto';
import * as bcrypt from 'bcrypt';
import { BlogRepository } from 'src/blog/repositories/blog.repository';
import { RatingRepository } from 'src/rating/repositories/rating.repository';
import { User } from '../models/user.model';
import { ScheduleRepository } from 'src/schedule/repositories/schedule.repository';

@Injectable()
export class UserService {
    constructor(
        private readonly userRepository: UserRepository,
        private readonly blogRepository: BlogRepository,
        private readonly ratingRepository: RatingRepository,
        private readonly scheduleRepository: ScheduleRepository,

    ) { }

    async createUser(userDto: CreateUserDto) {
        userDto.password = await bcrypt.hash(userDto.password, 10);

        // Check if user already existed
        const userInDb = await this.userRepository.findByCondition({
            email: userDto.email
        })

        if (userInDb) {
            throw new HttpException('User already exists', HttpStatus.BAD_REQUEST);

        }

        return await this.userRepository.create(userDto)
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

    async updateUser(filter, update) {
        if (update.refreshToken) {
            update.refreshToken = await bcrypt.hash(
                this.reverse(update.refreshToken),
                10,
            );
        }
        return await this.userRepository.findByConditionAndUpdate(filter, update);
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
        try {
            const user = await this.userRepository.findById(id);
            const blogs = await this.blogRepository.getByCondition({
                user: id
            })

            const ratings = await this.ratingRepository.getByCondition({
                mentor: id
            })

            const schedules = await this.scheduleRepository.getByCondition({
                user: id
            })

            await Promise.all(ratings.map(async (rating) => {
                await rating.populate({ path: 'mentee', select: '-password -refreshToken -date_of_birth' });
            }));

            // await user.populate({ path: 'post', strictPopulate: false })
            if (user) {
                const userObject = user.toObject ? user.toObject() : user;

                delete userObject.password;
                delete userObject.refreshToken;
                delete userObject.date_of_birth;

                return {
                    ...userObject,
                    blogs,
                    schedules,
                    ratings,
                };
            }
        } catch (error) {
            console.error(error);
            throw error;
        }
    }

    async getProfile(user: User) {
        try {
            if (user.role === "mentee") {
                return await this.userRepository.findById(user.id);
            }
            const returnUser = await this.userRepository.findById(user.id);

            const blogs = await this.blogRepository.getByCondition({
                user: user.id
            })

            const ratings = await this.ratingRepository.getByCondition({
                mentor: user.id
            })

            await Promise.all(ratings.map(async (rating) => {
                await rating.populate({ path: 'mentee', select: '-password -refreshToken -date_of_birth' });
            }));

            // await returnUser.populate({ path: 'post', strictPopulate: false })
            if (returnUser) {
                const userObject = user.toObject ? user.toObject() : user;

                return {
                    ...userObject,
                    blogs,
                    ratings
                };
            }
        } catch (error) {
            console.error(error);
            throw error;
        }
    }

    async getAllMentors() {
        const mentors = await this.userRepository.getByCondition(
            { role: 'mentor' },
            ['name', 'avatar', '_id', 'email', 'gender', 'phone']
        );

        return mentors
    }

    async searchMentor(keyword: string) {
        keyword = keyword.toLowerCase();

        const mentors = await this.userRepository.getByCondition(
            {
                role: 'mentor',
                name: { $regex: new RegExp(keyword, 'i') }, // Case-insensitive search
            },
            ['name', 'avatar', '_id', 'email', 'gender', 'phone']
        );

        return mentors;
    }





}
