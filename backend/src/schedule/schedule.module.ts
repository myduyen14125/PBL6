import { Module } from '@nestjs/common';
import { UserService } from 'src/user/services/user.service';
import { MongooseModule } from '@nestjs/mongoose';
import { UserRepository } from 'src/user/repositories/user.repository';
import { UserModule } from 'src/user/user.module';
import { UserSchema } from 'src/user/models/user.model';
import { AppointmentSchema } from 'src/appointment/models/appointment.model';
import { ScheduleSchema } from './models/schedule.model';
import { ScheduleController } from './controllers/schedule.controller';
import { ScheduleService } from './services/schedule.service';
import { ScheduleRepository } from './repositories/schedule.repository';
import { BlogSchema } from 'src/blog/models/blog.model';
import { BlogRepository } from 'src/blog/repositories/blog.repository';
import { RatingRepository } from 'src/rating/repositories/rating.repository';
import { RatingSchema } from 'src/rating/models/rating.model';

@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: 'Schedule',
                schema: ScheduleSchema
            },
            {
                name: 'User',
                schema: UserSchema
            },
            {
                name: 'Appointment',
                schema: AppointmentSchema
            },
            {
                name: 'Blog',
                schema: BlogSchema
            },
            {
                name: 'Rating',
                schema: RatingSchema
            }
        ]),
        UserModule
    ],
    controllers: [ScheduleController],
    providers: [ScheduleService, ScheduleRepository, UserService, UserRepository, BlogRepository, RatingRepository]
})
export class ScheduleModule { }
