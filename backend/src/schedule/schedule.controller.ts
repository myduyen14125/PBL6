import { Body, Controller, Delete, Get, Param, Patch, Post, Req, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { Role } from 'src/auth/role.decorator';
import { RoleGuard } from 'src/auth/role.guard';
import { CreateScheduleDto } from './schedule.dto';
import { ScheduleService } from './schedule.service';

@Controller('schedule')
export class ScheduleController {
    constructor(private readonly scheduleService: ScheduleService) { }

    @Post()
    @UseGuards(AuthGuard('jwt'), RoleGuard)
    @Role('mentor')
    async createSchedule(@Req() req: any, @Body() schedule: CreateScheduleDto) {
        return this.scheduleService.createSchedule(req.user, schedule);
    }

    @Post('create-schedules')
    @UseGuards(AuthGuard('jwt'), RoleGuard)
    @Role('mentor')
    async createManySchedules(@Req() req: any, @Body() schedules: CreateScheduleDto[]) {        
        return this.scheduleService.createManySchedules(req.user, schedules);
    }

    @Get()
    @UseGuards(AuthGuard('jwt'))
    async getUserSchedule(@Req() req: any) {
        return this.scheduleService.getUserSchedule(req.user);
    }

    
    @Get('by-user/:id')
    getAllSchedulesByUserId(@Param('id') id: string) {
        return this.scheduleService.getAllSchedulesByUserId(id);
    }

    @UseGuards(AuthGuard("jwt"))
    @Delete('delete-schedules')
    async deleteManySchedules(@Req() req: any, @Body() schedules: string[]) {
        return this.scheduleService.deleteManySchedules(req.user, schedules)
    }

    @UseGuards(AuthGuard("jwt"))
    @Delete(':id')
    async deleteSchedule(@Req() req: any, @Param('id') id: string) {
        return this.scheduleService.deleteSchedule(req.user, id)
    }
}
