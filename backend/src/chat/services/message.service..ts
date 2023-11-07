import { HttpException, HttpStatus, Injectable } from "@nestjs/common";
import { User } from "src/user/user.model";
import { CreateMessageDto } from "../dto/message.dto";
import { MessageRepository } from "../repositories/message.repository";
import { EventGateway } from "src/event/event.gateway";
import { ChatRepository } from "../repositories/chat.repository";

@Injectable()
export class MessageService {
    constructor(private readonly messageRepository: MessageRepository,
        private readonly chatRepository: ChatRepository,
        private eventGateway: EventGateway
    ) { }


    async createMessage(user: User, message: CreateMessageDto) {
        // handle chat participants logic  
        // chat exist
        const chatExist = await this.chatRepository.findById(message.chat)
        if (!chatExist) throw new HttpException('Invalid chat', HttpStatus.BAD_REQUEST);

        message.sender = user._id
        const createdMessage = await this.messageRepository.create(message)
        await this.chatRepository.findByIdAndUpdate(message.chat, {
            latest_message: message.text,
            seen: false,
            sender: user.id
        })

        this.eventGateway.sendNewMessage(createdMessage)
        return createdMessage
    }

}
