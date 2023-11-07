import { Injectable } from '@nestjs/common';
import { AwardRepository } from '../repositories/award.repository';
import { CreateAwardDto, UpdateAwardDto } from '../dtos/award.dto';
import { User } from 'src/user/user.model';
import { BioService } from './bio.service';

@Injectable()
export class AwardService {
    constructor(
        private readonly awardRepository: AwardRepository,
        private readonly bioService: BioService
    ) { }

    async createAward(user: User, award: CreateAwardDto) {
        const check = await this.bioService.checkOwnerShip(user, award.bio)
        if (check) {
            return await this.awardRepository.create(award)
        }
    }

    async updateAward(user: User, id: string, newAward: UpdateAwardDto) {
        const award = await this.awardRepository.findById(id)

        const check = await this.bioService.checkOwnerShip(user, award.bio._id)
        if (check) {
            return await this.awardRepository.findByIdAndUpdate(id, newAward)
        }

    }

    async deleteAward(user: User, id: string) {
        const award = await this.awardRepository.findById(id)
        const check = await this.bioService.checkOwnerShip(user, award.bio._id)
        if (check) {
            return await this.awardRepository.deleteOne(id);
        }
    }

}
