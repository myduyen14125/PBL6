import { Body, Controller, Get, Param, Patch, Query, Req, UploadedFile, UseGuards, UseInterceptors, ValidationPipe } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { FileInterceptor } from '@nestjs/platform-express';
import { PaginationRatingDto } from 'src/rating/rating.dto';
import { UpdatePasswordDto } from '../dto/password.dto';
import { PaginationUserDto, UpdateUserDto } from '../dto/user.dto';
import { UserService } from '../user.service';
import { PaginationCourseDto } from 'src/course/dtos/course.dto';
import { PaginationBlogDto } from 'src/blog/blog.dto';
import { Role } from 'src/auth/role.decorator';
import { RoleGuard } from 'src/auth/role.guard';

@Controller('user')
export class UserController {
    constructor(private readonly userService: UserService) { }
    
    @UseGuards(AuthGuard('jwt'))
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

    @UseGuards(AuthGuard('jwt'))
    @Patch()
    async updateUserInfo(@Req() req: any, @Body() user: UpdateUserDto) {
        return this.userService.updateUserInfo(req.user, user);
    }

    @UseGuards(AuthGuard('jwt'))
    @Patch('update-avatar')
    @UseInterceptors(FileInterceptor('avatar'))
    async updateUserAvatar(@Req() req: any, @UploadedFile() file) {
        return this.userService.updateAvatar(req.user, file);
    }

    @UseGuards(AuthGuard('jwt'))
    @Patch('change-password')
    async changePassword(@Req() req: any, @Body(new ValidationPipe()) passwordDto: UpdatePasswordDto) {
        return this.userService.changePassword(req.user, passwordDto);
    }

    @UseGuards(AuthGuard('jwt'), RoleGuard)
    @Role('admin')
    @Get('mentees')
    getAllMentees(@Query() { page, limit }: PaginationUserDto) {
        return this.userService.getAllMentees(page, limit);
    }

    @UseGuards(AuthGuard('jwt'), RoleGuard)
    @Role('admin')
    @Get('search')
    async searchMentee(@Query('name') keyword: string, @Query() { page, limit }: PaginationUserDto) {
        return await this.userService.searchMentee(keyword, page, limit);
    }
    
    @Get(':id')
    getUserById(@Param('id') id: string) {
        return this.userService.getUserById(id);
    }
    
}
