import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { BaseRepository } from '../../base.repository';
import { Chat } from '../models/chat.model';

@Injectable()
export class ChatRepository extends BaseRepository<Chat> {
    constructor(
        @InjectModel('Chat')
        private readonly chatModel: Model<Chat>,
    ) {
        super(chatModel);
    }
}