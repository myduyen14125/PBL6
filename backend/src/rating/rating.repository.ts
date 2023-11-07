import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { BaseRepository } from '../base.repository';
import { Rating } from './rating.model';


@Injectable()
export class RatingRepository extends BaseRepository<Rating> {
    constructor(
        @InjectModel('Rating')
        private readonly ratingModel: Model<Rating>,
    ) {
        super(ratingModel);
    }

    async countDocuments(filter) {
        return this.ratingModel.countDocuments(filter);
    }
}