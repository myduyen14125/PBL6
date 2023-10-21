import { Body, Controller, Delete, Get, Param, Patch, Post, Query, Req, UseGuards, ValidationPipe } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ChatService } from '../services/chat.service';
import { CreateChatDto } from '../dto/chat.dto';

@Controller('chat')
export class ChatController {
    constructor(private readonly chatService: ChatService) { }

    @Post()
    @UseGuards(AuthGuard('jwt'))
    async createChat(@Req() req: any, @Body(new ValidationPipe()) chat: CreateChatDto) {
        return this.chatService.createChat(req.user, chat);
    }

    // @Get()
    // @UseGuards(AuthGuard('jwt'))
    // async getUserSchedule(@Req() req: any) {
    //     return this.scheduleService.getUserSchedule(req.user);
    // }

    // @Get(':id')
    // @UseGuards(AuthGuard('jwt'))
    // async getScheduleById(@Req() req: any, @Param('id') id: string) {
    //     return this.scheduleService.getScheduleById(req.user, id);
    // }

}
