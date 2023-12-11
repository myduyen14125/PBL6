import { Controller, Get, Query } from '@nestjs/common';
import { UserService } from '../user.service';
import { PaginationUserDto } from '../dto/user.dto';

@Controller('mentor')
export class MentorController {
    constructor(private readonly userService: UserService) { }

    @Get()
    getAllMentors(@Query() { page, limit }: PaginationUserDto) {
        return this.userService.getAllMentors(page, limit);
    }

    @Get('search')
    async searchMentors(@Query('name') keyword: string, @Query('expertise') keyword2: string, @Query() { page, limit }: PaginationUserDto) {
        return await this.userService.searchMentor(keyword, keyword2, page, limit);
    }
}