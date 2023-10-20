import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { AppointmentSchema } from './models/appointment.model';
import { AppointmentController } from './controllers/appointment.controller';
import { AppointmentService } from './services/appointment.service';
import { AppointmentRepository } from './repositories/appointment.repository';
import { UserSchema } from 'src/user/models/user.model';
import { ScheduleSchema } from 'src/schedule/models/schedule.model';
import { RatingSchema } from 'src/rating/models/rating.model';
import { BlogSchema } from 'src/blog/models/blog.model';
import { UserRepository } from 'src/user/repositories/user.repository';
import { UserService } from 'src/user/services/user.service';
import { UserModule } from 'src/user/user.module';
import { ScheduleService } from 'src/schedule/services/schedule.service';
import { ScheduleRepository } from 'src/schedule/repositories/schedule.repository';
import { BlogService } from 'src/blog/services/blog.service';
import { BlogRepository } from 'src/blog/repositories/blog.repository';
import { ScheduleModule } from 'src/schedule/schedule.module';
import { BlogModule } from 'src/blog/blog.module';
import { RatingModule } from 'src/rating/rating.module';

@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: 'Appointment',
                schema: AppointmentSchema
            }
        ]),
        forwardRef(() => UserModule),
        forwardRef(() => BlogModule),
        forwardRef(() => ScheduleModule),
        forwardRef(() => RatingModule),
        forwardRef(() => BlogModule),
        // forwardRef(() => AppointmentModule),
    ],

    controllers: [AppointmentController],
    providers: [AppointmentService, AppointmentRepository],
    exports: [AppointmentService]
})
export class AppointmentModule { }
