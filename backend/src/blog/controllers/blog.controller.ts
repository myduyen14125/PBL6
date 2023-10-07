import { Body, Controller, Delete, Get, Param, Patch, Post, Query, Req, UseGuards, ValidationPipe } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { CreateBlogDto, UpdateBlogDto } from '../dto/blog.dto';
import { BlogService } from '../services/blog.service';

@Controller('blog')
export class BlogController {
    constructor(private readonly blogService: BlogService) { }

    @Get()
    getAllBlogs(@Query() query) {
        return this.blogService.getAllBlogs();
    }

    @Get(':id')
    getBlogById(@Param('id') id: string) {
        return this.blogService.getBlogById(id);
    }

    @Post()
    @UseGuards(AuthGuard('jwt'))
    async createBlog(@Req() req: any, @Body(new ValidationPipe()) post: CreateBlogDto) {
        return this.blogService.createBlog(req.user, post);
    }


    @UseGuards(AuthGuard("jwt"))
    @Delete(':id')
    async deleteBlog(@Req() req: any, @Param('id') id: string) {
        return this.blogService.deleteBlog(req.user, id)
    }

    @UseGuards(AuthGuard("jwt"))
    @Patch(':id')
    async updateBlog(@Req() req: any, @Param('id') id: string, @Body(new ValidationPipe()) blog: UpdateBlogDto) {
        return this.blogService.updateBlog(req.user, id, blog)
    }

}
