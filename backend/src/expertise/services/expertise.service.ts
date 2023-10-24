import { Injectable } from '@nestjs/common';
import { CreateExpertiseDto, UpdateExpertiseDto } from '../dto/expertise.dto';
import { User } from 'src/user/models/user.model';
import { ExpertiseRepository } from '../repositories/expertise.repository';

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
