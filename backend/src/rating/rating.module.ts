import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { UserSchema } from 'src/user/models/user.model';
import { UserModule } from 'src/user/user.module';
import { UserRepository } from 'src/user/repositories/user.repository';
import { UserService } from 'src/user/services/user.service';
import { BlogRepository } from 'src/blog/repositories/blog.repository';
import { RatingSchema } from './models/rating.model';
import { AppointmentSchema } from 'src/appointment/models/appointment.model';
import { RatingController } from './controllers/rating.controller';
import { RatingService } from './services/rating.service';
import { RatingRepository } from './repositories/rating.repository';
import { AppointmentService } from 'src/appointment/services/appointment.service';
import { AppointmentRepository } from 'src/appointment/repositories/appointment.repository';
import { AppointmentModule } from 'src/appointment/appointment.module';
import { BlogService } from 'src/blog/services/blog.service';
import { BlogSchema } from 'src/blog/models/blog.model';
import { ScheduleSchema } from 'src/schedule/models/schedule.model';
import { ScheduleRepository } from 'src/schedule/repositories/schedule.repository';

@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: 'Appointment',
                schema: AppointmentSchema
            },
            {
                name: 'User',
                schema: UserSchema
            },
            {
                name: 'Rating',
                schema: RatingSchema
            },
            {
                name: 'Blog',
                schema: BlogSchema
            },
            {
                name: 'Schedule',
                schema: ScheduleSchema
            },
        ]),
        UserModule,
        AppointmentModule

    ],
    controllers: [RatingController],
    providers: [RatingService, RatingRepository, ScheduleRepository, UserRepository, AppointmentService, AppointmentRepository, BlogRepository]
})
export class RatingModule { }
