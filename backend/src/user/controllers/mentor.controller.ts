import { Controller, Get, Query } from '@nestjs/common';
import { PaginationUserDto } from '../dto/user.dto';
import { UserService } from '../user.service';

@Controller('mentor')
export class MentorController {
    constructor(private readonly userService: UserService) { }

    @Get()
    getAllMentors(@Query() { page, limit }: PaginationUserDto) {
        return this.userService.getAllMentors(page, limit);
    }

    @Get('search')
    async searchMentors(@Query('name') name: string, @Query('expertise') expertise: string, @Query() { page, limit }: PaginationUserDto) {
        return await this.userService.searchMentor(name, expertise, page, limit);
    }
}