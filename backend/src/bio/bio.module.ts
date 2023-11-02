import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { AwardController } from './controllers/award.controller';
import { BioController } from './controllers/bio.controller';
import { EducationController } from './controllers/education.controller';
import { ExperienceController } from './controllers/experience.controller';
import { SkillController } from './controllers/skill.controller.ts';
import { AwardSchema } from './models/award.model';
import { BioSchema } from './models/bio.model';
import { EducationSchema } from './models/education.model';
import { ExperienceSchema } from './models/experience.model';
import { SkillSchema } from './models/skill.model';
import { AwardRepository } from './repositories/award.repository';
import { BioRepository } from './repositories/bio.repository';
import { EducationRepository } from './repositories/education.repository';
import { ExperienceRepository } from './repositories/experience.repository';
import { SkillRepository } from './repositories/skill.repository';
import { AwardService } from './services/award.service';
import { BioService } from './services/bio.service';
import { EducationService } from './services/education.service';
import { ExperienceService } from './services/experience.service';
import { SkillService } from './services/skill.service';


@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: 'Bio',
                schema: BioSchema
            },
            {
                name: 'Education',
                schema: EducationSchema
            },
            {
                name: 'Experience',
                schema: ExperienceSchema
            },
            {
                name: 'Skill',
                schema: SkillSchema
            },
            {
                name: 'Award',
                schema: AwardSchema
            },
        ]),

    ],

    controllers: [BioController, AwardController, EducationController, SkillController, ExperienceController],
    providers: [BioService, AwardService, SkillService, ExperienceService, EducationService, BioRepository, AwardRepository, SkillRepository, ExperienceRepository, EducationRepository],
    exports: [BioService, AwardService, EducationService, SkillService, ExperienceService]
})
export class BioModule { }
