import { Body, Controller, Delete, Param, Patch, Post, Req, UseGuards, ValidationPipe } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { CreateEducationDto, UpdateEducationDto } from '../dtos/education.dto';
import { EducationService } from '../services/education.service';

@Controller('education')
export class EducationController {
    constructor(private readonly educationService: EducationService) { }

    @Post()
    @UseGuards(AuthGuard('jwt'))
    async createEducation(@Req() req: any, @Body(new ValidationPipe()) education: CreateEducationDto) {
        return this.educationService.createEducation(req.user, education);
    }

    @UseGuards(AuthGuard("jwt"))
    @Patch(':id')
    async updateEducation(@Req() req: any, @Param('id') id: string, @Body(new ValidationPipe()) education: UpdateEducationDto) {
        return this.educationService.updateEducation(req.user, id, education)
    }

    @UseGuards(AuthGuard("jwt"))
    @Delete(':id')
    async deleteEducation(@Req() req: any, @Param('id') id: string) {
        return this.educationService.deleteEducation(req.user, id)
    }
}
