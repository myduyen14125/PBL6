import { Module, forwardRef } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { JwtModule } from '@nestjs/jwt';
import { PassportModule } from '@nestjs/passport';
import { UserModule } from 'src/user/user.module';
import { AuthController } from './auth.controller';
import { JwtStrategy } from '../auth/jwt.strategy';
import { AuthService } from './auth.service';

@Module({
    imports: [

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
        forwardRef(() => UserModule)
    ],

    controllers: [AuthController],
    providers: [AuthService, JwtStrategy],
    exports: [AuthService]

})
export class AuthModule { }
