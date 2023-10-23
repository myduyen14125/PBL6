import { Body, Controller, Delete, Get, Param, Patch, Post, Query, Req, UseGuards, ValidationPipe } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { AwardService } from '../services/award.service';
import { CreateAwardDto, UpdateAwardDto } from '../dtos/award.dto';

@Controller('award')
export class AwardController {
    constructor(private readonly awardService: AwardService) { }

    @Post()
    @UseGuards(AuthGuard('jwt'))
    async createAward(@Req() req: any, @Body(new ValidationPipe()) award: CreateAwardDto) {
        return this.awardService.createAward(req.user, award);
    }

    @UseGuards(AuthGuard("jwt"))
    @Patch(':id')
    async updateAward(@Req() req: any, @Param('id') id: string, @Body(new ValidationPipe()) award: UpdateAwardDto) {
        return this.awardService.updateAward(req.user, id, award)
    }

    @UseGuards(AuthGuard("jwt"))
    @Delete(':id')
    async deleteAward(@Req() req: any, @Param('id') id: string) {
        return this.awardService.deleteAward(req.user, id)
    }
}
