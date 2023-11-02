import { Body, Controller, Delete, Get, Param, Post, Req, UseGuards, ValidationPipe } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ScheduleService } from '../services/schedule.service';
import { CreateScheduleDto } from '../dto/schedule.dto';
import { Role } from 'src/auth/role.decorator';
import { RoleGuard } from 'src/auth/role.guard';

@Controller('schedule')
export class ScheduleController {
    constructor(private readonly scheduleService: ScheduleService) { }

    @Post()
    @UseGuards(AuthGuard('jwt'), RoleGuard)
    @Role('mentor')
    async createSchedule(@Req() req: any, @Body(new ValidationPipe()) schedule: CreateScheduleDto) {
        return this.scheduleService.createSchedule(req.user, schedule);
    }

    @Post('create-schedules')
    @UseGuards(AuthGuard('jwt'), RoleGuard)
    @Role('mentor')
    async createManySchedules(@Req() req: any, @Body(new ValidationPipe()) schedules: CreateScheduleDto[]) {
        return this.scheduleService.createManySchedules(req.user, schedules);
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
