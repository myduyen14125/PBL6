import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { AppointmentModule } from 'src/appointment/appointment.module';
import { RatingController } from './controllers/rating.controller';
import { RatingSchema } from './models/rating.model';
import { RatingRepository } from './repositories/rating.repository';
import { RatingService } from './services/rating.service';
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
