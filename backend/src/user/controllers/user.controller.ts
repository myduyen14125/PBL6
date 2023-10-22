import { Controller, Get, Req, UseGuards, Param, Query } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { UserService } from '../services/user.service';
import { PaginationPostDto } from 'src/blog/dto/blog.dto';
import { PaginationRatingDto } from 'src/rating/dto/rating.dto';

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

    @Get(':id/blogs')
    getAllBlogsByUserId(@Param('id') id: string, @Query() { page, limit }: PaginationPostDto) {
        return this.userService.getAllBlogsByUserId(id, page, limit);
    }

    @Get(':id/schedules')
    getAllSchedulesByUserId(@Param('id') id: string) {
        return this.userService.getAllSchedulesByUserId(id);
    }

    @Get(':id/ratings')
    getAllRatingsByUserId(@Param('id') id: string, @Query() { page, limit }: PaginationRatingDto) {
        return this.userService.getAllRatingsByUserId(id, page, limit);
    }

}