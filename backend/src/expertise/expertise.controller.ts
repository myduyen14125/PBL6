import { Body, Controller, Get, Post } from '@nestjs/common';
import { CreateExpertiseDto } from './expertise.dto';
import { ExpertiseService } from './expertise.service';

@Controller('expertise')
export class ExpertiseController {
    constructor(private readonly expertiseService: ExpertiseService) { }

    @Get()
    getAllExpertises() {
        return this.expertiseService.getAllExpertises();
    }

    @Post()
    async createExpertise(@Body() expertise: CreateExpertiseDto) {
        return this.expertiseService.createExpertise(expertise);
    }
}
