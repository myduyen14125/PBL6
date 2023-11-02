import { Body, Controller, Get, Param, Patch, Post, Req, UseGuards, ValidationPipe } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { CreateChatDto } from '../dto/chat.dto';
import { ChatService } from '../services/chat.service';

@Controller('chat')
export class ChatController {
    constructor(private readonly chatService: ChatService) { }

    @Post()
    @UseGuards(AuthGuard('jwt'))
    async createChat(@Req() req: any, @Body(new ValidationPipe()) chat: CreateChatDto) {
        return this.chatService.createChat(req.user, chat);
    }

    @Get()
    @UseGuards(AuthGuard('jwt'))
    async getUserChats(@Req() req: any) {
        return this.chatService.getUserChats(req.user);
    }

    @Get(':id')
    @UseGuards(AuthGuard('jwt'))
    async getAllMessageByChatId(@Req() req: any, @Param('id') id: string) {
        return this.chatService.getAllMessageByChatId(req.user, id);
    }

    @Patch(':id')
    @UseGuards(AuthGuard('jwt'))
    async setSeenLatestMessage(@Req() req: any, @Param('id') id: string) {
        return this.chatService.setSeenLatestMessage(req.user, id);
    }

}
