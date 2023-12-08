import { Body, Controller, Delete, Param, Patch, Post, Req, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { CreateSkillDto, UpdateSkillDto } from '../dtos/skill.dto';
import { SkillService } from '../services/skill.service';

@Controller('skill')
export class SkillController {
    constructor(private readonly skillService: SkillService) { }

    @Post()
    @UseGuards(AuthGuard('jwt'))
    async createSkill(@Req() req: any, @Body() skill: CreateSkillDto) {
        return this.skillService.createSkill(req.user, skill);
    }

    @UseGuards(AuthGuard("jwt"))
    @Patch(':id')
    async updateSkill(@Req() req: any, @Param('id') id: string, @Body() skill: UpdateSkillDto) {
        return this.skillService.updateSkill(req.user, id, skill)
    }

    @UseGuards(AuthGuard("jwt"))
    @Delete(':id')
    async deleteSkill(@Req() req: any, @Param('id') id: string) {
        return this.skillService.deleteSkill(req.user, id)
    }
}
