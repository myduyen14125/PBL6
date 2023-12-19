import { HttpException, HttpStatus, Inject, Injectable, forwardRef } from "@nestjs/common";
import { CourseService } from "src/course/services/course.service";
import { User } from "src/user/user.model";
import { CreateLessonDto, UpdateLessonDto } from "../dtos/lesson.dto";
import { LessonRepository } from "../repositories/lesson.repository";

@Injectable()
export class LessonService {
    constructor(private readonly lessonRepository: LessonRepository,
        @Inject(forwardRef(() => CourseService)) private readonly courseService: CourseService,
    ) { }

    async createLesson(user: User, lesson: CreateLessonDto) {
        await this.courseService.checkOwnership(user, lesson.course)
        const { getVideoDurationInSeconds } = require('get-video-duration')

        await getVideoDurationInSeconds(lesson.video).then((duration) => {
            this.courseService.updateDuration(lesson.course, true, duration) 
        })
        
        const lastLesson = await this.lessonRepository.getByCondition(
            {
                course: lesson.course
            },
            null,
            {
                sort: {
                    order: -1,
                }
            }
        );
        lesson.order = ((lastLesson[0]?.order as number) || 0) + 1;
        return await this.lessonRepository.create(lesson)
    }

    async getLessonsByCourseId(id: string) {
        const lessons = await this.lessonRepository.getByCondition(
            {
                course: id
            },
            null,
            {
                sort: {
                    order: 1,
                },
                select: '-video'
            },
        );
        return lessons
    }

    async getLessonById(user: User, id: string) {
        const lesson = await this.lessonRepository.findById(id);
        await this.courseService.checkParticipation(user, lesson.course._id)
        return lesson
    }

    async updateLesson(user: User, id: string, dto: UpdateLessonDto) {
        const lesson = await this.lessonRepository.findById(id);
        if(!lesson) throw new HttpException('No lesson with this id', HttpStatus.BAD_REQUEST);
        await this.courseService.checkOwnership(user, lesson.course._id)
        
        if(dto.video != lesson.video) {
            const { getVideoDurationInSeconds } = require('get-video-duration')
            await getVideoDurationInSeconds(lesson.video).then((duration) => {
                this.courseService.updateDuration(lesson.course._id, false, duration) 
                // console.log(duration);
            })
            
            await getVideoDurationInSeconds(dto.video).then((duration) => {
                this.courseService.updateDuration(lesson.course._id, true, duration) 
                // console.log(duration);
            })
        }
        
        return await this.lessonRepository.findByIdAndUpdate(id, dto)
    }

    async deleteLesson(user: User, id: string){
        const lesson = await this.lessonRepository.findById(id);
        if(!lesson) throw new HttpException('No lesson with this id', HttpStatus.BAD_REQUEST);
        await this.courseService.checkOwnership(user, lesson.course._id)

        const { getVideoDurationInSeconds } = require('get-video-duration')
        await getVideoDurationInSeconds(lesson.video).then((duration) => {
            this.courseService.updateDuration(lesson.course._id, false, duration) 
        })

        return await this.lessonRepository.deleteOne(id)
    }
}
