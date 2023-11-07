import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { BaseRepository } from '../base.repository';
import { Expertise } from './expertise.model';


@Injectable()
export class ExpertiseRepository extends BaseRepository<Expertise> {
    constructor(
        @InjectModel('Expertise')
        private readonly expertiseModel: Model<Expertise>,
    ) {
        super(expertiseModel);
    }

    async countDocuments(filter) {
        return this.expertiseModel.countDocuments(filter);
    }
}