import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ScheduleController } from './controllers/schedule.controller';
import { ScheduleService } from './services/schedule.service';
import { ScheduleRepository } from './repositories/schedule.repository';
import { UserSchema } from 'src/user/models/user.model';
import { ScheduleSchema } from 'src/schedule/models/schedule.model';
import { RatingSchema } from 'src/rating/models/rating.model';
import { BlogSchema } from 'src/blog/models/blog.model';
import { AppointmentSchema } from 'src/appointment/models/appointment.model';
import { UserModule } from 'src/user/user.module';
import { BlogModule } from 'src/blog/blog.module';
import { RatingModule } from 'src/rating/rating.module';
import { AppointmentModule } from 'src/appointment/appointment.module';


@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: 'Schedule',
                schema: ScheduleSchema
            }
        ]),
        forwardRef(() => UserModule),
        forwardRef(() => BlogModule),
        // forwardRef(() => ScheduleModule),
        forwardRef(() => RatingModule),
        forwardRef(() => BlogModule),
        forwardRef(() => AppointmentModule),

    ],

    controllers: [ScheduleController],
    providers: [ScheduleService, ScheduleRepository],
    exports: [ScheduleService]
})
export class ScheduleModule { }
