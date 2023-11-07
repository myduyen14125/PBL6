import { Injectable } from '@nestjs/common';
import { EducationRepository } from '../repositories/education.repository';
import { User } from 'src/user/user.model';
import { BioService } from './bio.service';
import { CreateEducationDto, UpdateEducationDto } from '../dtos/education.dto';

@Injectable()
export class EducationService {
    constructor(
        private readonly educationRepository: EducationRepository,
        private readonly bioService: BioService
    ) { }

    async createEducation(user: User, education: CreateEducationDto) {
        const check = await this.bioService.checkOwnerShip(user, education.bio)
        if (check) {
            return await this.educationRepository.create(education)
        }
    }

    async updateEducation(user: User, id: string, newEducation: UpdateEducationDto) {
        const education = await this.educationRepository.findById(id)

        const check = await this.bioService.checkOwnerShip(user, education.bio._id)
        if (check) {
            return await this.educationRepository.findByIdAndUpdate(id, newEducation)
        }

    }

    async deleteEducation(user: User, id: string) {
        const education = await this.educationRepository.findById(id)
        const check = await this.bioService.checkOwnerShip(user, education.bio._id)
        if (check) {
            return await this.educationRepository.deleteOne(id);
        }
    }

}
