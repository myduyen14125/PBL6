import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ScheduleModule } from 'src/schedule/schedule.module';
import { UserModule } from 'src/user/user.module';
import { AppointmentController } from './controllers/appointment.controller';
import { AppointmentSchema } from './models/appointment.model';
import { AppointmentRepository } from './repositories/appointment.repository';
import { AppointmentService } from './services/appointment.service';

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
