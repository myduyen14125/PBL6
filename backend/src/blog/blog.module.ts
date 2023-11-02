import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { BlogController } from './controllers/blog.controller';
import { BlogSchema } from './models/blog.model';
import { BlogRepository } from './repositories/blog.repository';
import { BlogService } from './services/blog.service';

@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: 'Blog',
                schema: BlogSchema
            }
        ]),
    ],
    controllers: [BlogController],
    providers: [BlogService, BlogRepository],
    exports: [BlogService]
})
export class BlogModule { }
