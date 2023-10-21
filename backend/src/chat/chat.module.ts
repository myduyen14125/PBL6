import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ChatSchema } from './models/chat.model';
import { ChatController } from './controllers/chat.controller';
import { ChatService } from './services/chat.service';
import { ChatRepository } from './repositories/chat.repository';

@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: 'Chat',
                schema: ChatSchema
            }
        ]),

    ],
    controllers: [ChatController],
    providers: [ChatService, ChatRepository],
    exports: [ChatService]
})
export class ChatModule { }
