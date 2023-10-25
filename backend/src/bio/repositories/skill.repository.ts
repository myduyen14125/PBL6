import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { BaseRepository } from '../../base.repository';
import { Skill } from '../models/skill.model';


@Injectable()
export class SkillRepository extends BaseRepository<Skill> {
    constructor(
        @InjectModel('Skill')
        private readonly skillModel: Model<Skill>,
    ) {
        super(skillModel);
    }

    async countDocuments(filter) {
        return this.skillModel.countDocuments(filter);
    }
}