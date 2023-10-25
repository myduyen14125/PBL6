import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { BaseRepository } from '../../base.repository';
import { Experience } from '../models/experience.model';


@Injectable()
export class ExperienceRepository extends BaseRepository<Experience> {
    constructor(
        @InjectModel('Experience')
        private readonly experienceModel: Model<Experience>,
    ) {
        super(experienceModel);
    }

    async countDocuments(filter) {
        return this.experienceModel.countDocuments(filter);
    }
}