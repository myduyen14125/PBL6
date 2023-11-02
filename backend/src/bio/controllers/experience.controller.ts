import { Body, Controller, Delete, Param, Patch, Post, Req, UseGuards, ValidationPipe } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { CreateExperienceDto, UpdateExperienceDto } from '../dtos/experience.dto';
import { ExperienceService } from '../services/experience.service';

@Controller('experience')
export class ExperienceController {
    constructor(private readonly experienceService: ExperienceService) { }

    @Post()
    @UseGuards(AuthGuard('jwt'))
    async createExperience(@Req() req: any, @Body(new ValidationPipe()) experience: CreateExperienceDto) {
        return this.experienceService.createExperience(req.user, experience);
    }

    @UseGuards(AuthGuard("jwt"))
    @Patch(':id')
    async updateExperience(@Req() req: any, @Param('id') id: string, @Body(new ValidationPipe()) experience: UpdateExperienceDto) {
        return this.experienceService.updateExperience(req.user, id, experience)
    }

    @UseGuards(AuthGuard("jwt"))
    @Delete(':id')
    async deleteExperience(@Req() req: any, @Param('id') id: string) {
        return this.experienceService.deleteExperience(req.user, id)
    }
}
