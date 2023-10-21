import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { BaseRepository } from '../../base.repository';
import { Message } from '../models/message.model';

@Injectable()
export class MessageRepository extends BaseRepository<Message> {
    constructor(
        @InjectModel('Message')
        private readonly messageModel: Model<Message>,
    ) {
        super(messageModel);
    }
}