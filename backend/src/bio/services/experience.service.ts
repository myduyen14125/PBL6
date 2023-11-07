import { Injectable } from '@nestjs/common';
import { User } from 'src/user/user.model';
import { BioService } from './bio.service';
import { ExperienceRepository } from '../repositories/experience.repository';
import { CreateExperienceDto, UpdateExperienceDto } from '../dtos/experience.dto';

@Injectable()
export class ExperienceService {
    constructor(
        private readonly experienceRepository: ExperienceRepository,
        private readonly bioService: BioService
    ) { }

    async createExperience(user: User, experience: CreateExperienceDto) {
        const check = await this.bioService.checkOwnerShip(user, experience.bio)
        if (check) {
            return await this.experienceRepository.create(experience)
        }
    }

    async updateExperience(user: User, id: string, newExperience: UpdateExperienceDto) {
        const experience = await this.experienceRepository.findById(id)

        const check = await this.bioService.checkOwnerShip(user, experience.bio._id)
        if (check) {
            return await this.experienceRepository.findByIdAndUpdate(id, newExperience)
        }

    }

    async deleteExperience(user: User, id: string) {
        const experience = await this.experienceRepository.findById(id)
        const check = await this.bioService.checkOwnerShip(user, experience.bio._id)
        if (check) {
            return await this.experienceRepository.deleteOne(id);
        }
    }

}
