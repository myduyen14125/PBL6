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
    })
  ],

  controllers: [AuthController, UserController, BlogController],
  providers: [UserService, AuthService, UserRepository, JwtStrategy, BlogRepository, BlogService],
})
export class UserModule { }
