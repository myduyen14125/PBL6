import { Body, Controller, Get, Post, ValidationPipe } from '@nestjs/common';
import { CreateExpertiseDto } from '../dto/expertise.dto';
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
