import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { User } from 'src/user/user.model';
import { CreateBioDto } from '../dtos/bio.dto';
import { BioRepository } from '../repositories/bio.repository';

@Injectable()
export class BioService {
    constructor(
        private readonly bioRepository: BioRepository
    ) { }

    async createBio(user: User) {
        const bio = new CreateBioDto
        bio.user = user.id
        return await this.bioRepository.create(bio)
    }

    async checkOwnerShip(user: User, id: string) {
        const bio = await this.bioRepository.findById(id)
        if (!bio.user.equals(user._id)) throw new HttpException('No Permission', HttpStatus.BAD_REQUEST);
        return true
    }

    async getUserBio(id: String) {
        const bio = await this.bioRepository.findByCondition({user: id})
        await bio.populate(
            [
                { path: 'awards'},
                { path: 'experiences'},
                { path: 'skills'},
                { path: 'educations'},
            ]
        )
        return bio.toObject()
    }
}
