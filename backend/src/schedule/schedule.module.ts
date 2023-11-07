import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ScheduleController } from './schedule.controller';
import { ScheduleService } from './schedule.service';
import { ScheduleRepository } from './schedule.repository';
import { ScheduleSchema } from 'src/schedule/schedule.model';
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
