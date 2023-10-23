import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { BioRepository } from '../repositories/bio.repository';
import { CreateBioDto } from '../dtos/bio.dto';
import { User } from 'src/user/models/user.model';
import { AwardRepository } from '../repositories/award.repository';
import { SkillRepository } from '../repositories/skill.repository';
import { EducationRepository } from '../repositories/education.repository';
import { ExperienceRepository } from '../repositories/experience.repository';

@Injectable()
export class BioService {
    constructor(
        private readonly bioRepository: BioRepository,
        private readonly awardRepository: AwardRepository,
        private readonly skillRepository: SkillRepository,
        private readonly educationRepository: EducationRepository,
        private readonly experienceRepository: ExperienceRepository,
    ) { }

    async createBio(user: User) {
        const bio = new CreateBioDto
        bio.user = user.id
        return await this.bioRepository.create(bio)
    }



    async checkOwnerShip(user: User, id: string) {
        console.log(user._id);

        const bio = await this.bioRepository.findById(id)
        console.log(bio.user);

        if (!bio.user.equals(user._id)) throw new HttpException('No Permission', HttpStatus.BAD_REQUEST);
        return true
    }

    async getUserBio(id: String) {
        const bio = await this.bioRepository.findByCondition({
            user: id
        })

        const awards = await this.awardRepository.getByCondition({ bio: bio.id })
        const skills = await this.skillRepository.getByCondition({ bio: bio.id })
        const educations = await this.educationRepository.getByCondition({ bio: bio.id })
        const experiences = await this.experienceRepository.getByCondition({ bio: bio.id })


        const bioData = bio.toObject();

        const result = {
            ...bioData,
            awards: awards,
            skills: skills,
            educations: educations,
            experiences: experiences
        };


        return result
    }
}
