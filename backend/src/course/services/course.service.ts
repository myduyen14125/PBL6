import { HttpException, HttpStatus, Injectable } from "@nestjs/common";
import { CourseRepository } from "../repositories/schedule.repository";
import { CreateCourseDto, UpdateCourseDto } from "../dto/course.dto";
import { User } from "src/user/models/user.model";

@Injectable()
export class CourseService {
    constructor(
        private readonly courseRepository: CourseRepository
    ) { }


    async createCourse(user: User, courseDto: CreateCourseDto) {
        courseDto.creator = user.id
        return await this.courseRepository.create(courseDto)
    }

    async getAllCourses(page: number, limit: number = 10) {
        const count = await this.courseRepository.countDocuments({})
        const countPage = Math.ceil(count / limit)
        const course = await this.courseRepository.getByCondition({

        },
            null,
            {
                sort: {
                    _id: -1,
                },
                skip: (page - 1) * limit,
                limit: limit
            },
            // { path: 'user', select: 'name avatar email role number_of_mentees' });
        );

        return {
            count, countPage, course
        }
    }

    async getCourseById(id: string) {
        const course = await this.courseRepository.findById(id);
        if (course) {
            throw new HttpException('No course with this id', HttpStatus.BAD_REQUEST);
        }
        return course
    }

    async getCourseByUserId(id: string, page: number, limit: number = 10) {
        const count = await this.courseRepository.countDocuments({ creator: id })
        const countPage = Math.ceil(count / limit)
        const courses = await this.courseRepository.getByCondition(
            {
                creator: id
            },
            null,
            {
                sort: {
                    _id: -1,
                },
                skip: (page - 1) * limit,
                limit: limit
            },
        );
        return {
            count,
            countPage,
            courses
        }
    }

    async deleteCourse(user: User, id: string) {
        const course = await this.courseRepository.findById(id)
        if (!course.creator.equals(user._id)) {
            throw new HttpException('Only creator has permission', HttpStatus.BAD_REQUEST);
        }
        return await this.courseRepository.deleteOne(id);

    }

    async updateCourse(user: User, id: string, course: UpdateCourseDto) {
        const courseCheck = await this.courseRepository.findById(id)
        if (!courseCheck.creator.equals(user._id)) {
            throw new HttpException('Only creator has permission', HttpStatus.BAD_REQUEST);
        }
        return await this.courseRepository.findByIdAndUpdate(id, course)
    }
} 