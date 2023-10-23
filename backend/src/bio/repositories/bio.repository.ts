import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { BaseRepository } from '../../base.repository';
import { Bio } from '../models/bio.model';


@Injectable()
export class BioRepository extends BaseRepository<Bio> {
    constructor(
        @InjectModel('Bio')
        private readonly bioModel: Model<Bio>,
    ) {
        super(bioModel);
    }

    async countDocuments(filter) {
        return this.bioModel.countDocuments(filter);
    }
}