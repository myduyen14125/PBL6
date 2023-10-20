import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { RatingSchema } from './models/rating.model';
import { RatingController } from './controllers/rating.controller';
import { RatingService } from './services/rating.service';
import { RatingRepository } from './repositories/rating.repository';
import { UserSchema } from 'src/user/models/user.model';
import { ScheduleSchema } from 'src/schedule/models/schedule.model';
import { BlogSchema } from 'src/blog/models/blog.model';
import { AppointmentSchema } from 'src/appointment/models/appointment.model';
import { AppointmentService } from 'src/appointment/services/appointment.service';
import { AppointmentModule } from 'src/appointment/appointment.module';
import { UserService } from 'src/user/services/user.service';
import { AppointmentRepository } from 'src/appointment/repositories/appointment.repository';
import { ScheduleService } from 'src/schedule/services/schedule.service';
import { UserRepository } from 'src/user/repositories/user.repository';
import { ScheduleRepository } from 'src/schedule/repositories/schedule.repository';
import { BlogRepository } from 'src/blog/repositories/blog.repository';
import { BlogService } from 'src/blog/services/blog.service';
import { UserModule } from 'src/user/user.module';
import { BlogModule } from 'src/blog/blog.module';
import { ScheduleModule } from 'src/schedule/schedule.module';
@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: 'Rating',
                schema: RatingSchema
            }
        ]),
        // AppointmentModule,
        forwardRef(() => UserModule),
        forwardRef(() => BlogModule),
        forwardRef(() => ScheduleModule),
        // forwardRef(() => RatingModule),
        forwardRef(() => BlogModule),
        forwardRef(() => AppointmentModule),
    ],
    controllers: [RatingController],
    providers: [RatingService, RatingRepository],
    exports: [RatingService]
})
export class RatingModule { }
