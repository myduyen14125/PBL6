import { ScheduleModule } from 'src/schedule/schedule.module';
import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { UserSchema } from './models/user.model';
import { BlogModule } from 'src/blog/blog.module';
import { PassportModule } from '@nestjs/passport';
import { JwtModule } from '@nestjs/jwt';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { AuthController } from './controllers/auth.controller';
import { UserController } from './controllers/user.controller';
import { MentorController } from './controllers/mentor.controller';
import { UserService } from './services/user.service';
import { AuthService } from './services/auth.service';
import { UserRepository } from './repositories/user.repository';
import { JwtStrategy } from './jwt.strategy';
import { AppointmentModule } from 'src/appointment/appointment.module';
import { RatingModule } from 'src/rating/rating.module';

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
        // forwardRef(() => UserModule),
        forwardRef(() => BlogModule),
        forwardRef(() => ScheduleModule),
        forwardRef(() => RatingModule),
        forwardRef(() => BlogModule),
        forwardRef(() => AppointmentModule),
    ],

    controllers: [AuthController, UserController, MentorController],
    providers: [UserService, AuthService, UserRepository, JwtStrategy],
    exports: [UserService]

})
export class UserModule { }
