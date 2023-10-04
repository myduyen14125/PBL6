import { Module } from '@nestjs/common';
import { UserService } from 'src/user/services/user.service';
import { MongooseModule } from '@nestjs/mongoose';
import { UserRepository } from 'src/user/repositories/user.repository';
import { UserModule } from 'src/user/user.module';
import { UserSchema } from 'src/user/models/user.model';
import { BlogController } from './controllers/blog.controller';
import { BlogService } from './services/blog.service';
import { BlogRepository } from './repositories/blog.repository';
import { BlogSchema } from './models/blog.model';

@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: 'Blog',
                schema: BlogSchema
            },
            {
                name: 'User',
                schema: UserSchema
            },
        ]),
        UserModule
    ],
    controllers: [BlogController],
    providers: [BlogService, BlogRepository, UserService, UserRepository]
})
export class BlogModule { }
