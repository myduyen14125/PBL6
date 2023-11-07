import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ExpertiseController } from './expertise.controller';
import { ExpertiseService } from './expertise.service';
import { ExpertiseRepository } from './expertise.repository';
import { ExpertiseSchema } from './expertise.model';

@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: 'Expertise',
                schema: ExpertiseSchema
            }
        ]),
    ],
    controllers: [ExpertiseController],
    providers: [ExpertiseService, ExpertiseRepository],
    exports: [ExpertiseService]
})
export class ExpertiseModule { }
