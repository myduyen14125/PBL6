import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ExpertiseController } from './controllers/expertise.controller';
import { ExpertiseService } from './services/expertise.service';
import { ExpertiseRepository } from './repositories/expertise.repository';
import { ExpertiseSchema } from './models/expertise.model';

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
