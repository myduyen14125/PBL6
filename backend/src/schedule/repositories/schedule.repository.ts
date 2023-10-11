import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { BaseRepository } from '../../base.repository';
import { Schedule } from '../models/schedule.model';


@Injectable()
export class ScheduleRepository extends BaseRepository<Schedule> {
    constructor(
        @InjectModel('Schedule')
        private readonly scheduleModel: Model<Schedule>,
    ) {
        super(scheduleModel);
    }

    async countDocuments(filter) {
        return this.scheduleModel.countDocuments(filter);
    }
}