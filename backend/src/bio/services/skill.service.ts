import { Injectable } from '@nestjs/common';
import { User } from 'src/user/user.model';
import { BioService } from './bio.service';
import { SkillRepository } from '../repositories/skill.repository';
import { CreateSkillDto, UpdateSkillDto } from '../dtos/skill.dto';

@Injectable()
export class SkillService {
    constructor(
        private readonly skillRepository: SkillRepository,
        private readonly bioService: BioService
    ) { }

    async createSkill(user: User, skill: CreateSkillDto) {
        const check = await this.bioService.checkOwnerShip(user, skill.bio)
        if (check) {
            return await this.skillRepository.create(skill)
        }
    }

    async updateSkill(user: User, id: string, newSkill: UpdateSkillDto) {
        const skill = await this.skillRepository.findById(id)

        const check = await this.bioService.checkOwnerShip(user, skill.bio._id)
        if (check) {
            return await this.skillRepository.findByIdAndUpdate(id, newSkill)
        }

    }

    async deleteSkill(user: User, id: string) {
        const skill = await this.skillRepository.findById(id)
        const check = await this.bioService.checkOwnerShip(user, skill.bio._id)
        if (check) {
            return await this.skillRepository.deleteOne(id);
        }
    }

}
