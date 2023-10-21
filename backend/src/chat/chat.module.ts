import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ChatSchema } from './models/chat.model';
import { ChatController } from './controllers/chat.controller';
import { ChatService } from './services/chat.service';
import { ChatRepository } from './repositories/chat.repository';
import { MessageController } from './controllers/message.controller';
import { MessageService } from './services/message.service.';
import { MessageRepository } from './repositories/message.repository';
import { MessageSchema } from './models/message.model';
import { EventModule } from 'src/event/event.module';

@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: 'Chat',
                schema: ChatSchema
            },
            {
                name: 'Message',
                schema: MessageSchema
            }
        ]),
        EventModule

    ],
    controllers: [ChatController, MessageController],
    providers: [ChatService, ChatRepository, MessageService, MessageRepository],
    exports: [ChatService, MessageService]
})
export class ChatModule { }
