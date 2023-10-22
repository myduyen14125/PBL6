import { HttpException, HttpStatus, Injectable } from "@nestjs/common";
import { User } from "src/user/models/user.model";
import { CreateMessageDto } from "../dto/message.dto";
import { MessageRepository } from "../repositories/message.repository";
import { EventGateway } from "src/event/event.gateway";

@Injectable()
export class MessageService {
    constructor(private readonly messageRepository: MessageRepository,
        private eventGateway: EventGateway
    ) { }


    async createMessage(user: User, message: CreateMessageDto) {
        // handle chat participants logic  


        message.sender = user._id
        const createdMessage = await this.messageRepository.create(message)

        this.eventGateway.sendNewMessage(createdMessage)
        return createdMessage
    }

}
