import { HttpException, HttpStatus, Injectable } from "@nestjs/common";
import { User } from "src/user/models/user.model";
import { ChatRepository } from "../repositories/chat.repository";
import { CreateChatDto } from "../dto/chat.dto";

@Injectable()
export class ChatService {
    constructor(private readonly chatRepository: ChatRepository,
    ) { }


    async createChat(user: User, chat: CreateChatDto) {


        const checkUser = chat.participants.find(id => id === user.id)
        if (!checkUser) {

            throw new HttpException('You do not have permission for this action', HttpStatus.BAD_REQUEST);

        }

        // check if chat already existed
        const chatExist = await this.chatRepository.findByCondition({
            participants: chat.participants
        })
        if (chatExist) {
            throw new HttpException('Existed chat', HttpStatus.BAD_REQUEST);

        }
        const createdChat = await this.chatRepository.create(chat)
        return createdChat.populate({ path: 'participants', select: 'name avatar' })

    }

    // search chat



}