import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { CreateBlogDto, UpdateBlogDto } from './blog.dto';
import { User } from 'src/user/user.model';
import { BlogRepository } from './blog.repository';

@Injectable()
export class BlogService {
    constructor(
        private readonly blogRepository: BlogRepository,

    ) { }

    async getAllBlogs(page: number, limit: number = 10) {
        const count = await this.blogRepository.countDocuments({})
        const countPage = Math.ceil(count / limit)
        const blogs = await this.blogRepository.getByCondition({

        },
            null,
            {
                sort: {
                    _id: -1,
                },
                skip: (page - 1) * limit,
                limit: limit
            },
            { path: 'user', select: 'name avatar email role number_of_mentees' });


        return {
            count, countPage, blogs
        }
    }

    async getBlogById(id: string) {
        try {
            const blog = await this.blogRepository.findById(id);
            await blog.populate({ path: 'user', select: 'name avatar email role number_of_mentees' })
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
        return newBlog.populate({ path: 'user', select: 'name avatar email role number_of_mentees' })

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
            throw new HttpException('Only creator has permission', HttpStatus.BAD_REQUEST);
        }
        return (await this.blogRepository.findByIdAndUpdate(id, blog)).populate({ path: 'user', select: '-password -refreshToken' })
    }

    async getAllBlogsByUserId(id: string, page: number, limit: number = 10) {
        const count = await this.blogRepository.countDocuments({ user: id })
        const countPage = Math.ceil(count / limit)
        const blogs = await this.blogRepository.getByCondition(
            {
                user: id
            },
            null,
            {
                sort: {
                    _id: -1,
                },
                skip: (page - 1) * limit,
                limit: limit
            },
            { path: 'user', select: 'name avatar email role number_of_mentees' });
        return {
            count,
            countPage,
            blogs
        }
    }
}
