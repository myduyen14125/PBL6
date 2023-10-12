import { Controller, Get, Req, UseGuards, Param, Query } from '@nestjs/common';
import { UserService } from '../services/user.service';

@Controller('mentor')
export class MentorController {
    constructor(private readonly userService: UserService) { }

    @Get()
    getAllMentors(@Query() query) {
        return this.userService.getAllMentors();
    }

    @Get('search')
    async searchMentors(@Query('name') keyword: string) {
        return await this.userService.searchMentor(keyword);
    }
}