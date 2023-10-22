import { Controller, Get, Req, UseGuards, Param, Query } from '@nestjs/common';
import { UserService } from '../services/user.service';
import { PaginationMentorDto } from '../dto/user.dto';

@Controller('mentor')
export class MentorController {
    constructor(private readonly userService: UserService) { }

    @Get()
    getAllMentors(@Query() { page, limit }: PaginationMentorDto) {
        return this.userService.getAllMentors(page, limit);
    }

    @Get('search')
    async searchMentors(@Query('name') keyword: string, @Query() { page, limit }: PaginationMentorDto) {
        return await this.userService.searchMentor(keyword, page, limit);
    }
}