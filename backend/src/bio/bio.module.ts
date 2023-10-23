import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { BioSchema } from './models/bio.model';
import { BioController } from './controllers/bio.controller';
import { BioService } from './services/bio.service';
import { BioRepository } from './repositories/bio.repository';
import { EducationSchema } from './models/education.model';
import { ExperienceSchema } from './models/experience.model';
import { SkillSchema } from './models/skill.model';
import { AwardSchema } from './models/award.model';
import { AwardRepository } from './repositories/award.repository';
import { SkillRepository } from './repositories/skill.repository';
import { ExperienceRepository } from './repositories/experience.repository';
import { EducationRepository } from './repositories/education.repository';
import { AwardController } from './controllers/award.controller';
import { AwardService } from './services/award.service';
import { SkillService } from './services/skill.service';
import { ExperienceService } from './services/experience.service';
import { EducationService } from './services/education.service';
import { EducationController } from './controllers/education.controller';
import { SkillController } from './controllers/skill.controller.ts';
import { ExperienceController } from './controllers/experience.controller';


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
