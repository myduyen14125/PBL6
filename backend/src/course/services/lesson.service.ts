import { Inject, Injectable, forwardRef } from "@nestjs/common";
import { CourseService } from "src/course/services/course.service";
import { User } from "src/user/user.model";
import { CreateLessonDto } from "../dtos/lesson.dto";
import { LessonRepository } from "../repositories/lesson.repository";

@Injectable()
export class LessonService {
    constructor(private readonly lessonRepository: LessonRepository,
        @Inject(forwardRef(() => CourseService)) private readonly courseService: CourseService,
    ) { }

    async createLesson(user: User, lesson: CreateLessonDto) {
        await this.courseService.checkOwnership(user, lesson.course)

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
        lesson.archived = false
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


}
