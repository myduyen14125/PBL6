import { Controller, Get, Req, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';

@Controller('user')
export class UserController {
    @UseGuards(AuthGuard())
    @Get('profile')
    async getProfile(@Req() req: any) {
        console.log(req.user);
        return req.user;
    }

    @UseGuards(AuthGuard('jwt'))
    @Get('blogs')
    async getBlogs(@Req() req: any) {
        await req.user.populate('blogs')
        return req.user.blogs
    }
}