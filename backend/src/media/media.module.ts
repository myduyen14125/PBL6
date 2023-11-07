import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { MediaSchema } from './media.model';
import { MediaService } from './media.service';
import { MediaRepository } from './media.repository';
import { MediaController } from './media.controller';
import { ConfigModule } from '@nestjs/config';

@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: 'Media',
                schema: MediaSchema,
            },
        ]),
        ConfigModule,
    ],
    controllers: [MediaController],
    providers: [MediaService, MediaRepository],
    exports: [MediaService]
})
export class MediaModule { }