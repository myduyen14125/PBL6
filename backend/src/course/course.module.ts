import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { CourseController } from './controllers/course.controller';
import { CourseSchema } from './models/course.model';
import { CourseService } from './services/course.service';
import { CourseRepository } from './repositories/course.repository';
import { LessonController } from './controllers/lesson.controller';
import { LessonService } from './services/lesson.service';
import { LessonRepository } from './repositories/lesson.repository';
import { LessonSchema } from './models/lesson.model';

@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: 'Course',
                schema: CourseSchema
            },
            {
                name: 'Lesson',
                schema: LessonSchema
            }
        ]),
    ],
    controllers: [CourseController, LessonController],
    providers: [CourseService, CourseRepository, LessonService, LessonRepository],
    exports: [CourseService, LessonService]
})
export class CourseModule { }
