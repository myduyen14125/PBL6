import { Body, Controller, Delete, Get, Param, Patch, Post, Query, Req, UseGuards, ValidationPipe } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ScheduleService } from '../services/schedule.service';
import { CreateScheduleDto } from '../dto/schedule.dto';

@Controller('schedule')
export class ScheduleController {
    constructor(private readonly scheduleService: ScheduleService) { }

    @Post()
    @UseGuards(AuthGuard('jwt'))
    async createSchedule(@Req() req: any, @Body(new ValidationPipe()) schedule: CreateScheduleDto) {
        return this.scheduleService.createSchedule(req.user, schedule);
    }

    @Post('create-schedules')
    @UseGuards(AuthGuard('jwt'))
    async createSchedules(@Req() req: any, @Body(new ValidationPipe()) schedules: CreateScheduleDto[]) {
        return this.scheduleService.createSchedules(req.user, schedules);
    }


    @Get()
    @UseGuards(AuthGuard('jwt'))
    async getUserSchedule(@Req() req: any) {
        return this.scheduleService.getUserSchedule(req.user);
    }

    @Get(':id')
    @UseGuards(AuthGuard('jwt'))
    async getScheduleById(@Req() req: any, @Param('id') id: string) {
        return this.scheduleService.getScheduleById(req.user, id);
    }

}
