import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UserModule } from './user/user.module';
import { ConfigModule } from '@nestjs/config';
import { MongooseModule } from '@nestjs/mongoose';
import { BlogModule } from './blog/blog.module';
import { AppointmentModule } from './appointment/appointment.module';
import { RatingModule } from './rating/rating.module';
import { ScheduleModule } from './schedule/schedule.module';
import { BioModule } from './bio/bio.module';

@Module({
  imports: [
    UserModule,
    BlogModule,
    AppointmentModule,
    RatingModule,
    ScheduleModule,
    ConfigModule.forRoot(),
    MongooseModule.forRoot(process.env.DB_URI),
    BioModule,



  ],
  controllers: [],
  providers: [],
})
export class AppModule { }
