import { Body, Controller, Delete, Get, Param, Patch, Post, Req, UseGuards, ValidationPipe } from "@nestjs/common";
import { AuthGuard } from "@nestjs/passport";
import { CreateLessonDto, UpdateLessonDto } from "../dtos/lesson.dto";
import { LessonService } from "../services/lesson.service";


@Controller('lesson')
export class LessonController {
    constructor(private readonly lessonService: LessonService) { }

    @Post()
    @UseGuards(AuthGuard('jwt'))
    async createLesson(@Req() req: any, @Body(new ValidationPipe()) lessonDto: CreateLessonDto) {
        return this.lessonService.createLesson(req.user, lessonDto);
    }

    @Get(':id')
    @UseGuards(AuthGuard('jwt'))
    async getLessonById(@Req() req: any, @Param('id') id: string) {
        return this.lessonService.getLessonById(req.user, id);
    }
    
    @Patch(':id') 
    @UseGuards(AuthGuard('jwt'))
    async updateLesson(@Req() req: any, @Param('id') id: string, @Body() dto: UpdateLessonDto) {
        return this.lessonService.updateLesson(req.user, id, dto);
    }

    @Delete(':id')
    @UseGuards(AuthGuard('jwt'))
    async deleteLesson(@Req() req: any, @Param('id') id: string) {
        return this.lessonService.deleteLesson(req.user, id);
    }


}
