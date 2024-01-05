import { Body, Controller, Delete, Get, Param, Patch, Post, Query, Req, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { CreateBlogDto, PaginationBlogDto, UpdateBlogDto } from './blog.dto';
import { BlogService } from './blog.service';

@Controller('blog')
export class BlogController {
    constructor(private readonly blogService: BlogService) { }

    @Get()
    getAllBlogs(@Query() { page, limit }: PaginationBlogDto) {
        return this.blogService.getAllBlogs(page, limit);
    }
    
    @Get('by-user/:id')
    getAllBlogsByUserId(@Param('id') id: string, @Query() { page, limit }: PaginationBlogDto) {
        return this.blogService.getAllBlogsByUserId(id, page, limit);
    }

    @Get('search')
    searchBlog(@Query('title') keyword: string, @Query() { page, limit }: PaginationBlogDto) {
        return this.blogService.searchBlog(keyword, page, limit);
    }

    @Get(':id')
    getBlogById(@Param('id') id: string) {
        return this.blogService.getBlogById(id);
    }

    @Post()
    @UseGuards(AuthGuard('jwt'))
    async createBlog(@Req() req: any, @Body() dto: CreateBlogDto) {
        return this.blogService.createBlog(req.user, dto);
    }

    @UseGuards(AuthGuard("jwt"))
    @Delete(':id')
    async deleteBlog(@Req() req: any, @Param('id') id: string) {
        return this.blogService.deleteBlog(req.user, id)
    }

    @UseGuards(AuthGuard("jwt"))
    @Patch(':id')
    async updateBlog(@Req() req: any, @Param('id') id: string, @Body() dto: UpdateBlogDto) {
        return this.blogService.updateBlog(req.user, id, dto)
    }

    
}
