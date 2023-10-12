import { Controller, Get, Req, UseGuards, Param, Query } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { UserService } from '../services/user.service';

@Controller('user')
export class UserController {
    constructor(private readonly userService: UserService) { }
    @UseGuards(AuthGuard())
    @Get('profile')
    async getProfile(@Req() req: any) {
        return this.userService.getProfile(req.user);
    }

    @UseGuards(AuthGuard('jwt'))
    @Get('blogs')
    async getBlogs(@Req() req: any) {
        await req.user.populate('blogs')
        return req.user.blogs
    }

    @Get(':id')
    getUserById(@Param('id') id: string) {
        return this.userService.getUserById(id);
    }

}