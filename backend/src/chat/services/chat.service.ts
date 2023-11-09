import { HttpException, HttpStatus, Inject, Injectable, forwardRef } from "@nestjs/common";
import { User } from "src/user/user.model";
import { ChatRepository } from "../repositories/chat.repository";
import { CreateChatDto } from "../dto/chat.dto";
import { MessageRepository } from "../repositories/message.repository";
import { EventGateway } from "src/event/event.gateway";

@Injectable()
export class ChatService {
    constructor(private readonly chatRepository: ChatRepository,
        private readonly messageRepository: MessageRepository,
        @Inject(forwardRef(() => EventGateway)) private eventGateway: EventGateway,
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

    // get Chat
    async getUserChats(user: User) {
        const chats = await this.chatRepository.getByCondition({
            participants: {
                $elemMatch: { $eq: user._id }
            },

        }, null,
            null,
            { path: 'participants', select: 'name avatar' })
        return chats
    }

    async getAllMessageByChatId(user: User, id: string) {
        // participants only

        const chatCheck = await this.chatRepository.findById(id)
        const isParticipant = chatCheck.participants.some(participant => participant._id.toString() === user._id.toString());
        if (!isParticipant) throw new HttpException('No Permission', HttpStatus.UNAUTHORIZED);

        const messages = await this.messageRepository.getByCondition({
            chat: id
        },
            null, null,
            { path: 'sender', select: 'name avatar' })
        return messages
    }


    // seen status
    async setSeenLatestMessage(user: User, id: string) {
        const chatCheck = await this.chatRepository.findById(id)
        const isParticipant = chatCheck.participants.some(participant => participant._id.toString() === user._id.toString());
        if (!isParticipant) throw new HttpException('No Permission', HttpStatus.UNAUTHORIZED);

        // must be other user

        const chat = await this.chatRepository.findByIdAndUpdate(id, {
            seen: true
        })

        this.eventGateway.seenStatus(chat)
        return chat
    }
}
