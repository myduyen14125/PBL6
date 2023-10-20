import { Injectable } from '@nestjs/common';
import { CreateBlogDto, UpdateBlogDto } from '../dto/blog.dto';
import { User } from 'src/user/models/user.model';
import { BlogRepository } from '../repositories/blog.repository';

@Injectable()
export class BlogService {
    constructor(
        private readonly blogRepository: BlogRepository,
    ) { }

    async getAllBlogs() {

        const blogs = await this.blogRepository.getByCondition({});

        await Promise.all(blogs.map(async (blog) => {
            await blog.populate({ path: 'user', select: '-password -refreshToken' });
        }));

        return blogs
    }

    async getBlogById(id: string) {
        try {
            const blog = await this.blogRepository.findById(id);
            await blog.populate({ path: 'user', select: '-password -refreshToken' })
            if (blog) {
                return blog;
            }
        } catch (error) {
            console.error(error);
            throw error;
        }
    }

    async createBlog(user: User, blog: CreateBlogDto) {
        blog.user = user.id;
        const newBlog = await this.blogRepository.create(blog)
        return newBlog.populate({ path: 'user', select: '-password -refreshToken' })

    }

    async deleteBlog(user: User, id: string) {
        const blog = await this.blogRepository.findById(id)
        if (blog.user.equals(user._id)) {
            return await this.blogRepository.deleteOne(id);
        }
    }

    async updateBlog(user: User, id: string, blog: UpdateBlogDto) {
        const check_post = await this.blogRepository.findById(id)
        if (!check_post.user.equals(user._id)) {
            return null;
        }
        return (await this.blogRepository.findByIdAndUpdate(id, blog)).populate({ path: 'user', select: '-password -refreshToken' })
    }
    ///////////////////////////////////////////////////////////////
    async getAllBlogsByUserId(id: string) {
        return await this.blogRepository.getByCondition({
            user: id
        })
    }
}
