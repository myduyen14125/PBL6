import { Injectable } from '@nestjs/common';
import { CreateExpertiseDto, UpdateExpertiseDto } from './expertise.dto';
import { ExpertiseRepository } from './expertise.repository';

@Injectable()
export class ExpertiseService {
    constructor(
        private readonly expertiseRepository: ExpertiseRepository,
    ) { }

    async createExpertise(expertise: CreateExpertiseDto) {
        return await this.expertiseRepository.create(expertise)
    }

    async getAllExpertises() {
        return await this.expertiseRepository.getByCondition({})
    }

    async updateExpertise(id: string, dto: UpdateExpertiseDto) {
        return await this.expertiseRepository.findByIdAndUpdate(id,dto)
    }

    async deleteExpertise(id: string) {
        return await this.expertiseRepository.deleteOne(id)
    }
}
