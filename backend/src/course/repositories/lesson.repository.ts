import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { BaseRepository } from '../../base.repository';
import { Lesson } from '../models/lesson.model';


@Injectable()
export class LessonRepository extends BaseRepository<Lesson> {
    constructor(
        @InjectModel('Lesson')
        private readonly lessonModel: Model<Lesson>,
    ) {
        super(lessonModel);
    }

    async countDocuments(filter) {
        return this.lessonModel.countDocuments(filter);
    }
}