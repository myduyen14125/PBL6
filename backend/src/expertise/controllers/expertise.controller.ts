import { Body, Controller, Delete, Get, Param, Patch, Post, Query, Req, UseGuards, ValidationPipe } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { CreateExpertiseDto, UpdateExpertiseDto } from '../dto/expertise.dto';
import { ExpertiseService } from '../services/expertise.service';

@Controller('expertise')
export class ExpertiseController {
    constructor(private readonly expertiseService: ExpertiseService) { }

    @Get()
    getAllExpertises() {
        return this.expertiseService.getAllExpertises();
    }

    @Post()
    async createExpertise(@Body(new ValidationPipe()) expertise: CreateExpertiseDto) {
        return this.expertiseService.createExpertise(expertise);
    }



}
