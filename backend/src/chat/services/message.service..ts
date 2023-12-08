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
        const existed = await this.chatRepository.findById(message.chat)
        if (!existed) throw new HttpException('Invalid chat', HttpStatus.BAD_REQUEST);

        message.sender = user._id
        const newMessage = await this.messageRepository.create(message)
        await this.chatRepository.findByIdAndUpdate(message.chat, {
            latest_message: message.text,
            seen: false,
            sender: user.id
        })

        // emit socket
        this.eventGateway.sendNewMessage(newMessage)
        return newMessage
    }

}
