import { Body, Controller, Get, Param, Post, Req, UseGuards, ValidationPipe } from "@nestjs/common";
import { AuthGuard } from "@nestjs/passport";
import { CreateLessonDto } from "../dtos/lesson.dto";
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

}
