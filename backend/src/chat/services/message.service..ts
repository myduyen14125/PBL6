import { HttpException, HttpStatus, Injectable } from "@nestjs/common";
import { User } from "src/user/models/user.model";
import { CreateMessageDto } from "../dto/message.dto";
import { MessageRepository } from "../repositories/message.repository";

@Injectable()
export class MessageService {
    constructor(private readonly messageRepository: MessageRepository,
    ) { }


    async createMessage(user: User, message: CreateMessageDto) {
        return await this.messageRepository.create(message)
    }




}
