import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ScheduleModule } from 'src/schedule/schedule.module';
import { UserModule } from 'src/user/user.module';
import { AppointmentController } from './appointment.controller';
import { AppointmentSchema } from './appointment.model';
import { AppointmentRepository } from './appointment.repository';
import { AppointmentService } from './appointment.service';

@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: 'Appointment',
                schema: AppointmentSchema
            }
        ]),
        forwardRef(() => UserModule),
        forwardRef(() => ScheduleModule),
    ],

    controllers: [AppointmentController],
    providers: [AppointmentService, AppointmentRepository],
    exports: [AppointmentService]
})
export class AppointmentModule { }
