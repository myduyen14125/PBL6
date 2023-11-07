import { Injectable } from '@nestjs/common';
import { CreateExpertiseDto, UpdateExpertiseDto } from './expertise.dto';
import { User } from 'src/user/user.model';
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
