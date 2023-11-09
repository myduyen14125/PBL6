import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { EventModule } from 'src/event/event.module';
import { ChatController } from './controllers/chat.controller';
import { MessageController } from './controllers/message.controller';
import { ChatSchema } from './models/chat.model';
import { MessageSchema } from './models/message.model';
import { ChatRepository } from './repositories/chat.repository';
import { MessageRepository } from './repositories/message.repository';
import { ChatService } from './services/chat.service';
import { MessageService } from './services/message.service.';

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
        forwardRef(() => EventModule),

    ],
    controllers: [ChatController, MessageController],
    providers: [ChatService, ChatRepository, MessageService, MessageRepository],
    exports: [ChatService, MessageService]
})
export class ChatModule { }
