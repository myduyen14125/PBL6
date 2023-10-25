import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { BaseRepository } from '../../base.repository';
import { Award } from '../models/award.model';


@Injectable()
export class AwardRepository extends BaseRepository<Award> {
    constructor(
        @InjectModel('Award')
        private readonly awardModel: Model<Award>,
    ) {
        super(awardModel);
    }

    async countDocuments(filter) {
        return this.awardModel.countDocuments(filter);
    }
}