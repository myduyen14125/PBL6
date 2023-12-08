import { Body, Controller, Post, Req, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { CreateMessageDto } from '../dto/message.dto';
import { MessageService } from '../services/message.service.';

@Controller('message')
export class MessageController {
    constructor(private readonly messageService: MessageService) { }

    @Post()
    @UseGuards(AuthGuard('jwt'))
    async createMessage(@Req() req: any, @Body() dto: CreateMessageDto) {
        return this.messageService.createMessage(req.user, dto);
    }
}
