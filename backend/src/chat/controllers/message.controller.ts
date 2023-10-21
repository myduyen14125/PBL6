import { Body, Controller, Delete, Get, Param, Patch, Post, Query, Req, UseGuards, ValidationPipe } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { MessageService } from '../services/message.service.';
import { CreateMessageDto } from '../dto/message.dto';

@Controller('message')
export class MessageController {
    constructor(private readonly messageService: MessageService) { }

    @Post()
    @UseGuards(AuthGuard('jwt'))
    async createMessage(@Req() req: any, @Body(new ValidationPipe()) message: CreateMessageDto) {
        return this.messageService.createMessage(req.user, message);
    }


}
