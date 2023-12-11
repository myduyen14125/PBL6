import { HttpException, HttpStatus, Injectable } from "@nestjs/common";
import { User } from "src/user/user.model";
import { CreateCourseDto, UpdateCourseDto } from "../dtos/course.dto";
import { CourseRepository } from "../repositories/course.repository";

@Injectable()
export class CourseService {
    constructor(
        private readonly courseRepository: CourseRepository,
    ) { }

    async createCourse(user: User, dto: CreateCourseDto) {
        dto.creator = user.id
        return await this.courseRepository.create(dto)
    }

    async getAllCourses(page: number, limit: number = 10) {
        const count = await this.courseRepository.countDocuments({})
        const countPage = Math.ceil(count / limit)
        const skip = (page - 1) * limit || 0
        const courses = await this.courseRepository.aggregate([
            {
                $lookup: {
                    from: 'users',
                    localField: 'creator',
                    foreignField: '_id',
                    as: 'creator'
                }
            }, 
            {
                $unwind: '$creator'
            },
            {
                $skip: skip
            },
            {
                $limit: Number(limit)
            },
            {
                $lookup: {
                    from: 'expertises', 
                    localField: 'creator.expertise',
                    foreignField: '_id',
                    as: 'creator.expertise'
                }
            },
            {
                $unwind: '$creator.expertise'
            },
            {
                $lookup: {
                    from: 'lessons', 
                    localField: '_id',
                    foreignField: 'course',
                    as: 'lessons'
                }
            },
            {
                $unwind: '$lessons'
            },
            {
                $group: {
                    _id: '$_id',
                    title: { $first: '$title' },
                    discount: { $first: '$discount' },
                    lesson_count: { $sum: 1 },
                    description: { $first: '$description' },
                    price: { $first: '$price' },
                    user_count: { $first: { $size: '$users' } },
                    image: { $first: '$image' },
                    creator: {
                        $first: {
                            name: '$creator.name',
                            avatar: '$creator.avatar',
                            expertise: {
                                name: '$creator.expertise.name'
                            }
                        }
                    }
                }
            },
            {
                $project: {
                    _id: 1,
                    title: 1,
                    lesson_count: 1,
                    description: 1,
                    price: 1,
                    discount: 1,
                    user_count: 1,
                    image: 1,
                    creator: 1
                }
            },
        ])    

        return {
            count, countPage, courses
        }
    }

    async getCourseById(id: string) {
        const courseCheck = await this.courseRepository.findById(id);
        if (!courseCheck) { 
            throw new HttpException('No course with this id', HttpStatus.BAD_REQUEST);
        }
        const course = await this.courseRepository.getByCondition(
            {
                _id: id
            },
            null,
            null,
            [
                {
                    path: 'creator',
                    select: 'name avatar expertise',
                    populate: {
                        path: 'expertise',
                        select: 'name',
                    }
                },
                {
                    path: 'lessons',
                }
            ]
        )

        const { getVideoDurationInSeconds } = require('get-video-duration')
        const courseObj = course[0].toObject();
        const updatedLessons = await Promise.all(courseObj.lessons.map(async (lesson) => {
            try {
                await getVideoDurationInSeconds(
                    lesson.video
                  ).then((duration) => {
                    lesson.duration = duration
                  })
                delete lesson.video
                return lesson;
            } catch (error) {
                console.error(`Error fetching duration for lesson ${lesson._id}: ${error.message}`);
                return lesson;
            }
        }));

        courseObj.lessons = updatedLessons;
        return courseObj
    }    

    async getAllCoursesByCreatorId(id: string, page: number, limit: number = 10) {
        const count = await this.courseRepository.countDocuments({})
        const countPage = Math.ceil(count / limit)
        const skip = (page - 1) * limit || 0
        const courses = await this.courseRepository.aggregate([
            {
                $match: {creator: id}
            },
            {
                $lookup: {
                    from: 'users',
                    localField: 'creator',
                    foreignField: '_id',
                    as: 'creator'
                }
            }, 
            {
                $unwind: '$creator'
            },
            {
                $skip: skip
            },
            {
                $limit: Number(limit)
            },
            {
                $lookup: {
                    from: 'expertises', 
                    localField: 'creator.expertise',
                    foreignField: '_id',
                    as: 'creator.expertise'
                }
            },
            {
                $unwind: '$creator.expertise'
            },
            {
                $lookup: {
                    from: 'lessons', 
                    localField: '_id',
                    foreignField: 'course',
                    as: 'lessons'
                }
            },
            {
                $unwind: '$lessons'
            },
            {
                $group: {
                    _id: '$_id',
                    title: { $first: '$title' },
                    lesson_count: { $sum: 1 },
                    description: { $first: '$description' },
                    price: { $first: '$price' },
                    user_count: { $first: { $size: '$users' } },
                    image: { $first: '$image' },
                    creator: {
                        $first: {
                            name: '$creator.name',
                            avatar: '$creator.avatar',
                            expertise: {
                                name: '$creator.expertise.name'
                            }
                        }
                    }
                }
            },
            {
                $project: {
                    _id: 1,
                    title: 1,
                    lesson_count: 1,
                    description: 1,
                    price: 1,
                    user_count: 1,
                    image: 1,
                    creator: 1
                }
            },
        ])    

        return {
            count, countPage, courses
        }
    }

    async deleteCourse(user: User, id: string) {
        const course = await this.courseRepository.findById(id)
        if (!course.creator.equals(user._id)) {
            throw new HttpException('Only creator has permission', HttpStatus.UNAUTHORIZED);
        }
        return await this.courseRepository.deleteOne(id);
    }

    async registerCourse(userId: string, courseId: string) {
        const course = await this.courseRepository.findById(courseId)
        if (!course) {
            throw new HttpException('Course does not exist', HttpStatus.BAD_REQUEST);
        }
        
        // cant join self-course
        if (course.creator.toString() === userId) {
            throw new HttpException('Cant join your own course', HttpStatus.BAD_REQUEST);
        }

        // cant join twice
        if (course.users.toString().includes(userId.toString())) {
            throw new HttpException('Already registered in current course', HttpStatus.BAD_REQUEST);
        }

        return await this.courseRepository.findByIdAndUpdate(courseId, {
            $push: {
                users: userId,
            },
        },)
    }

    async checkOwnership(user: User, id: string) {
        const course = await this.courseRepository.findById(id)
        if (!course.creator.equals(user._id)) throw new HttpException('No Permission', HttpStatus.UNAUTHORIZED);
        return true
    }

    async checkParticipation(user: User, id: string) {
        const courses = await this.courseRepository.getByCondition(
            {
                $or: [{ users: { $in: user.id } }, { creator: user.id }]
            });
        if (!courses) throw new HttpException('No Permission', HttpStatus.UNAUTHORIZED);
        return true
    }

    async getCurrentUserAllCourses(user: User, page: number, limit: number = 10) {
        let query =  { $or: [{ users: { $in: user.id } }, { creator: user.id }]}
        if(user.role === "admin") query = null
        const count = await this.courseRepository.countDocuments(query)
        const countPage = Math.ceil(count / limit)
        const tempCourses = await this.courseRepository.getByCondition(
            query,
            ['image', 'title', 'creator', 'description', 'price', 'discount', 'users'],
            {
                sort: {
                    _id: -1,
                },
                skip: (page - 1) * limit,
                limit: limit
            },
            {
                path: 'creator',
                select: 'name avatar expertise',
                populate: {
                    path: 'expertise',
                    select: 'name',
                }
            });
        
            const courses = tempCourses.map(course => {
                const courseObj = course.toObject();
                const user_count = courseObj.users ? courseObj.users.length : 0;
                delete courseObj.users
    
                return {
                    ...courseObj,
                    user_count,
                };
            });

        return {
            count, countPage, courses
        }
    }

    async updateCourse(user: User, id: string, course: UpdateCourseDto) {
        await this.checkOwnership(user, id);
        return await this.courseRepository.findByIdAndUpdate(id, course)
    }

    async getCoursePriceAndDiscountById(id: string) {
        const course = await this.courseRepository.findById(id);
        if (!course) { throw new HttpException('No course with this id', HttpStatus.BAD_REQUEST);}
        return course
    }
} 
