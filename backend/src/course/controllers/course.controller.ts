import { Body, Controller, Delete, Get, Param, Patch, Post, Query, Req, UseGuards, ValidationPipe } from "@nestjs/common";
import { AuthGuard } from "@nestjs/passport";
import { Role } from "src/auth/role.decorator";
import { RoleGuard } from "src/auth/role.guard";
import { CreateCourseDto, PaginationCourseDto, UpdateCourseDto } from "../dtos/course.dto";
import { CourseService } from "../services/course.service";


@Controller('course')
export class CourseController {
    constructor(private readonly courseService: CourseService) { }

    @Post()
    @UseGuards(AuthGuard('jwt'), RoleGuard)
    @Role('mentor')
    async createCourse(@Req() req: any, @Body(new ValidationPipe()) courseDto: CreateCourseDto) {
        return this.courseService.createCourse(req.user, courseDto);
    }

    @Get('my-courses')
    @UseGuards(AuthGuard("jwt"))
    getCurrentUserAllCourses(@Req() req: any, @Query() {page, limit}: PaginationCourseDto) {
        return this.courseService.getCurrentUserAllCourses(req.user, page, limit);
    }

    @Get(':id')
    getCourseById(@Param('id') id: string) {
        return this.courseService.getCourseById(id);
    }

    @UseGuards(AuthGuard("jwt"))
    @Delete(':id')
    async deleteCourse(@Req() req: any, @Param('id') id: string) {
        return this.courseService.deleteCourse(req.user, id)
    }

    @Get()
    getAllCourses(@Query() {page, limit}: PaginationCourseDto) {
        return this.courseService.getAllCourses(page, limit);
    }

    @UseGuards(AuthGuard("jwt"))
    @Patch(':id')
    async updateCourse(@Req() req: any, @Param('id') id: string, @Body() course: UpdateCourseDto) {
        return this.courseService.updateCourse(req.user, id, course)
    }






}
