import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { AppointmentSchema } from './models/appointment.model';
import { UserSchema } from 'src/user/models/user.model';
import { UserModule } from 'src/user/user.module';
import { AppointmentController } from './controllers/appointment.controller';
import { AppointmentService } from './services/appointment.service';
import { AppointmentRepository } from './repositories/appointment.repository';
import { UserRepository } from 'src/user/repositories/user.repository';
import { UserService } from 'src/user/services/user.service';
import { BlogModule } from 'src/blog/blog.module';
import { BlogService } from 'src/blog/services/blog.service';
import { BlogRepository } from 'src/blog/repositories/blog.repository';
import { BlogSchema } from 'src/blog/models/blog.model';
import { RatingSchema } from 'src/rating/models/rating.model';
import { RatingRepository } from 'src/rating/repositories/rating.repository';
import { RatingService } from 'src/rating/services/rating.service';
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
                name: 'Blog',
                schema: BlogSchema
            },
            {
                name: 'Rating',
                schema: RatingSchema
            },
            {
                name: 'Schedule',
                schema: ScheduleSchema
            },
        ]),
        UserModule,
        BlogModule
    ],
    controllers: [AppointmentController],
    providers: [AppointmentService, AppointmentRepository, ScheduleRepository, UserRepository, BlogRepository, RatingRepository, RatingService]
})
export class AppointmentModule { }
