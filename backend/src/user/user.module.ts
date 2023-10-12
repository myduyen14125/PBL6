import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { UserController } from './controllers/user.controller';
import { UserSchema } from './models/user.model';
import { UserService } from './services/user.service';
import { JwtModule } from '@nestjs/jwt';
import { PassportModule } from '@nestjs/passport';
import { UserRepository } from './repositories/user.repository';
import { AuthService } from './services/auth.service';
import { AuthController } from './controllers/auth.controller';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { JwtStrategy } from './jwt.strategy';
import { BlogSchema } from 'src/blog/models/blog.model';
import { BlogRepository } from 'src/blog/repositories/blog.repository';
import { BlogController } from 'src/blog/controllers/blog.controller';
import { BlogService } from 'src/blog/services/blog.service';
import { BlogModule } from 'src/blog/blog.module';
import { MentorController } from './controllers/mentor.controller';
import { AppointmentSchema } from 'src/appointment/models/appointment.model';
import { RatingSchema } from 'src/rating/models/rating.model';
import { RatingService } from 'src/rating/services/rating.service';
import { RatingRepository } from 'src/rating/repositories/rating.repository';
import { AppointmentRepository } from 'src/appointment/repositories/appointment.repository';
import { AppointmentModule } from 'src/appointment/appointment.module';
import { ScheduleSchema } from 'src/schedule/models/schedule.model';
import { ScheduleRepository } from 'src/schedule/repositories/schedule.repository';


@Module({
  imports: [
    MongooseModule.forFeature([
      {
        name: 'User',
        schema: UserSchema
      },
      {
        name: 'Blog',
        schema: BlogSchema
      },
      {
        name: 'Appointment',
        schema: AppointmentSchema
      },
      {
        name: 'Rating',
        schema: RatingSchema
      },
      {
        name: 'Schedule',
        schema: ScheduleSchema
      },

    ]),

    PassportModule.register({
      defaultStrategy: 'jwt',
      property: 'user',
      session: false,
    }),
    JwtModule.registerAsync({
      imports: [ConfigModule],
      useFactory: async (configService: ConfigService) => ({
        secret: configService.get('SECRETKEY'),
        signOptions: {
          expiresIn: configService.get('EXPIRESIN'),
        },
      }),
      inject: [ConfigService]
    })
  ],

  controllers: [AuthController, UserController, BlogController, MentorController],
  providers: [UserService, AuthService, BlogService, UserRepository, JwtStrategy, BlogRepository, RatingRepository, AppointmentRepository, ScheduleRepository],
})
export class UserModule { }
