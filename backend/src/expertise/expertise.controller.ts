import { Body, Controller, Delete, Get, Param, Patch, Post, UseGuards } from '@nestjs/common';
import { CreateExpertiseDto, UpdateExpertiseDto } from './expertise.dto';
import { ExpertiseService } from './expertise.service';
import { AuthGuard } from '@nestjs/passport';
import { Role } from 'src/auth/role.decorator';
import { RoleGuard } from 'src/auth/role.guard';

@Controller('expertise')
export class ExpertiseController {
    constructor(private readonly expertiseService: ExpertiseService) { }

    @Get()
    getAllExpertises() {
        return this.expertiseService.getAllExpertises();
    }

    @UseGuards(AuthGuard('jwt'), RoleGuard)
    @Role('admin')
    @Post()
    async createExpertise(@Body() dto: CreateExpertiseDto) {
        return this.expertiseService.createExpertise(dto);
    }

    @UseGuards(AuthGuard('jwt'), RoleGuard)
    @Role('admin')
    @Patch(':id')
    async updateExpertise(@Param('id') id: string, @Body() dto: UpdateExpertiseDto) {
        return this.expertiseService.updateExpertise(id, dto);
    }

    @UseGuards(AuthGuard('jwt'), RoleGuard)
    @Role('admin')
    @Delete(':id')
    async deleteBlog(@Param('id') id: string) {
        return this.expertiseService.deleteExpertise(id)
    }

}
