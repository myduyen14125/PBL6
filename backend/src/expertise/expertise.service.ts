import { Injectable } from '@nestjs/common';
import { CreateExpertiseDto } from './expertise.dto';
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
}
