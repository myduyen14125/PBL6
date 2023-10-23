import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { BaseRepository } from '../../base.repository';
import { Education } from '../models/education.model';


@Injectable()
export class EducationRepository extends BaseRepository<Education> {
    constructor(
        @InjectModel('Education')
        private readonly educationModel: Model<Education>,
    ) {
        super(educationModel);
    }

    async countDocuments(filter) {
        return this.educationModel.countDocuments(filter);
    }
}