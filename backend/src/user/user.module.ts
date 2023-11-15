import { Module, forwardRef } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { JwtModule } from '@nestjs/jwt';
import { MongooseModule } from '@nestjs/mongoose';
import { PassportModule } from '@nestjs/passport';
import { AppointmentModule } from 'src/appointment/appointment.module';
import { AuthModule } from 'src/auth/auth.module';
import { BioModule } from 'src/bio/bio.module';
import { BlogModule } from 'src/blog/blog.module';
import { MediaModule } from 'src/media/media.module';
import { RatingModule } from 'src/rating/rating.module';
import { ScheduleModule } from 'src/schedule/schedule.module';
import { JwtStrategy } from '../auth/jwt.strategy';
import { MentorController } from './controllers/mentor.controller';
import { UserController } from './controllers/user.controller';
import { UserSchema } from './user.model';
import { UserRepository } from './user.repository';
import { UserService } from './user.service';
import { CourseModule } from 'src/course/course.module';

@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: 'User',
                schema: UserSchema
            }
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
        }),
        forwardRef(() => AuthModule),
        forwardRef(() => BioModule),
        forwardRef(() => MediaModule),
        forwardRef(() => BlogModule),
        forwardRef(() => ScheduleModule),
        forwardRef(() => RatingModule),
        forwardRef(() => BlogModule),
        forwardRef(() => AppointmentModule),
        forwardRef(() => CourseModule),
    ],

    controllers: [UserController, MentorController],
    providers: [UserService, UserRepository, JwtStrategy],
    exports: [UserService]

})
export class UserModule { }