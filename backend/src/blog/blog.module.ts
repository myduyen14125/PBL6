import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { BlogController } from './controllers/blog.controller';
import { BlogService } from './services/blog.service';
import { BlogRepository } from './repositories/blog.repository';
import { BlogSchema } from './models/blog.model';
import { UserModule } from 'src/user/user.module';
import { ScheduleModule } from 'src/schedule/schedule.module';
import { RatingModule } from 'src/rating/rating.module';
import { AppointmentModule } from 'src/appointment/appointment.module';

@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: 'Blog',
                schema: BlogSchema
            }
        ]),
        forwardRef(() => UserModule),
        // forwardRef(() => BlogModule),
        forwardRef(() => ScheduleModule),
        forwardRef(() => RatingModule),
        forwardRef(() => BlogModule),
        forwardRef(() => AppointmentModule),
    ],
    controllers: [BlogController],
    providers: [BlogService, BlogRepository],
    exports: [BlogService]
})
export class BlogModule { }
