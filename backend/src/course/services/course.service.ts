import { HttpException, HttpStatus, Injectable } from "@nestjs/common";
import { User } from "src/user/user.model";
import { CreateCourseDto, UpdateCourseDto } from "../dtos/course.dto";
import { CourseRepository } from "../repositories/course.repository";
import { LessonService } from "./lesson.service";

@Injectable()
export class CourseService {
    constructor(
        private readonly courseRepository: CourseRepository,
        private readonly lessonService: LessonService,
    ) { }


    async createCourse(user: User, courseDto: CreateCourseDto) {
        courseDto.creator = user.id
        return await this.courseRepository.create(courseDto)
    }

    async getAllCourses() {
        const courses = await this.courseRepository.getByCondition({

        },
            null,
            {
                sort: {
                    _id: -1,
                },
            },
            {
                path: 'creator',
                select: 'name avatar expertise',
                populate: {
                    path: 'expertise',
                    select: 'name',
                }
            }
        );

        const result = courses.map(course => {
            const { users, ...courseWithoutUsers } = course.toObject();
            courseWithoutUsers.users_count = course.users.length;
            return courseWithoutUsers;
        });

        return result;
    }

    async getCourseById(id: string) {
        const course = await this.courseRepository.findById(id);
        if (!course) {
            throw new HttpException('No course with this id', HttpStatus.BAD_REQUEST);
        }

        const lessons = await this.lessonService.getLessonsByCourseId(course.id);
        const courseObject = course.toObject ? course.toObject() : course;
        const result = {
            ...courseObject,
            lessons: lessons
        };
        return result
    }


    async getAllCoursesByCreatorId(id: string) {
        const courses = await this.courseRepository.getByCondition(
            {
                creator: id
            },
            null,
            {
                sort: {
                    _id: -1,
                },
            },
            {
                path: 'creator',
                select: 'name avatar expertise',
                populate: {
                    path: 'expertise',
                    select: 'name',
                }
            }
        );
        const result = courses.map(course => {
            const { users, ...courseWithoutUsers } = course.toObject();
            courseWithoutUsers.users_count = course.users.length;
            return courseWithoutUsers;
        });

        return result;
    }

    async deleteCourse(user: User, id: string) {
        const course = await this.courseRepository.findById(id)
        if (!course.creator.equals(user._id)) {
            throw new HttpException('Only creator has permission', HttpStatus.BAD_REQUEST);
        }
        return await this.courseRepository.deleteOne(id);

    }

    async registerCourse(user: User, id: string) {
        const course = await this.courseRepository.findById(id)
        if (!course) {
            throw new HttpException('Course does not exist', HttpStatus.BAD_REQUEST);
        }
        // cant join self-course
        if (course.creator.equals(user._id)) {
            throw new HttpException('Cant join your own course', HttpStatus.BAD_REQUEST);
        }

        // cant join twice
        // console.log(course.users);
        // console.log(user);


        if (course.users.includes(user.id)) {
            throw new HttpException('Already registered in current course', HttpStatus.BAD_REQUEST);
        }

        return await this.courseRepository.findByIdAndUpdate(id, {
            $push: {
                users: user.id,
            },
        },)
        // return null
    }

    async checkOwnership(user: User, id: string) {
        console.log(user._id);

        const course = await this.courseRepository.findById(id)
        console.log(course.creator);

        if (!course.creator.equals(user._id)) throw new HttpException('No Permission', HttpStatus.BAD_REQUEST);
        return true
    }

    async checkParticipation(user: User, id: string) {
        const courses = await this.courseRepository.getByCondition(
            {
                $or: [{ users: { $in: user.id } }, { creator: user.id }]
            });
        if (!courses) throw new HttpException('No Permission', HttpStatus.BAD_REQUEST);
        return true
    }

    async getCurrentUserAllCourses(user: User) {
        const courses = await this.courseRepository.getByCondition(
            {
                $or: [{ users: { $in: user.id } }, { creator: user.id }]
            },
            null,
            {
                sort: {
                    _id: -1,
                },
            },
            {
                path: 'creator',
                select: 'name avatar expertise',
                populate: {
                    path: 'expertise',
                    select: 'name',
                }
            });
        const result = courses.map(course => {
            const { users, ...courseWithoutUsers } = course.toObject();
            courseWithoutUsers.users_count = course.users.length;
            return courseWithoutUsers;
        });

        return result;
    }

    async updateCourse(user: User, id: string, course: UpdateCourseDto) {
        await this.checkOwnership(user, id);
        return await this.courseRepository.findByIdAndUpdate(id, course)
    }

} 