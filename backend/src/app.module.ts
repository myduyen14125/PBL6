import { Module } from '@nestjs/common';
import { UserModule } from './user/user.module';
import { MongooseModule } from '@nestjs/mongoose';
import { BlogModule } from './blog/blog.module';
import { AppointmentModule } from './appointment/appointment.module';
import { RatingModule } from './rating/rating.module';
import { ScheduleModule } from './schedule/schedule.module';
import { BioModule } from './bio/bio.module';
import { ConfigModule } from '@nestjs/config';
import { EventModule } from './event/event.module';
import { ChatModule } from './chat/chat.module';
import { AuthModule } from './auth/auth.module';


@Module({
  imports: [
    UserModule,
    BlogModule,
    RatingModule,
    ScheduleModule,
    AppointmentModule,
    ConfigModule.forRoot(),
    MongooseModule.forRoot(process.env.DB_URI),
    EventModule,
    ChatModule,
    AuthModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule { }
