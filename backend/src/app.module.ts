import { Module } from '@nestjs/common';
import { UserModule } from './user/user.module';
import { MongooseModule } from '@nestjs/mongoose';
import { BlogModule } from './blog/blog.module';
import { AppointmentModule } from './appointment/appointment.module';
import { RatingModule } from './rating/rating.module';
import { ScheduleModule } from './schedule/schedule.module';
import { BioModule } from './bio/bio.module';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { EventModule } from './event/event.module';
import { ChatModule } from './chat/chat.module';
import { AuthModule } from './auth/auth.module';
import { MediaModule } from './media/media.module';
import { ExpertiseModule } from './expertise/expertise.module';
import { MailerModule, } from '@nestjs-modules/mailer';
import { join } from 'path';
import { HandlebarsAdapter } from '@nestjs-modules/mailer/dist/adapters/handlebars.adapter';
import { PaymentModule } from './payment/payment.module';
import { CourseModule } from './course/course.module';



@Module({
  imports: [
    BioModule,
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
    MediaModule,
    ExpertiseModule,
    MailerModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: async (config: ConfigService) => ({
        transport: {
          host: config.get('MAIL_HOST'),
          secure: false,
          auth: {
            user: config.get('MAIL_USER'),
            pass: config.get('MAIL_PASSWORD'),
          },
        },
        defaults: {
          from: `"IT-Mentor" <${config.get('MAIL_FROM')}>`,
        },
        template: {
          dir: join(__dirname, 'src/templates/email'),
          adapter: new HandlebarsAdapter(),
          options: {
            strict: true,
          },
        },
      }),
      inject: [ConfigService],
    }),
    PaymentModule,
    CourseModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule { }
