import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { AppointmentModule } from 'src/appointment/appointment.module';
import { RatingController } from './rating.controller';
import { RatingSchema } from './rating.model';
import { RatingRepository } from './rating.repository';
import { RatingService } from './rating.service';
@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: 'Rating',
                schema: RatingSchema
            }
        ]),
        forwardRef(() => AppointmentModule),
    ],
    controllers: [RatingController],
    providers: [RatingService, RatingRepository],
    exports: [RatingService]
})
export class RatingModule { }
