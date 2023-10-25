import { Body, Controller, Delete, Get, Param, Patch, Post, Query, Req, UseGuards, ValidationPipe } from '@nestjs/common';
import { AppointmentService } from '../services/appointment.service';
import { CreateAppointmentDto, UpdateAppointmentDto } from '../dto/appointment.dto';
import { AuthGuard } from '@nestjs/passport';



@Controller('appointment')
export class AppointmentController {
    constructor(private readonly appointmentService: AppointmentService) { }

    @Post()
    @UseGuards(AuthGuard('jwt'))
    async createAppointment(@Req() req: any, @Body(new ValidationPipe()) appointment: CreateAppointmentDto) {
        // console.log(mentor);

        return this.appointmentService.createAppointment(req.user, appointment);
    }

    @Get(':id')
    @UseGuards(AuthGuard('jwt'))
    getAppointmentById(@Req() req: any, @Param('id') id: string) {
        console.log(req.user);

        return this.appointmentService.getAppointmentById(req.user, id);
    }

    @Get()
    @UseGuards(AuthGuard('jwt'))

    async getAllUsersAppointments(@Req() req: any) {
        return this.appointmentService.getAllUsersAppointments(req.user._id)
    }



    @UseGuards(AuthGuard("jwt"))
    @Patch(':id/confirm')
    async confirmAppointment(@Req() req: any, @Param('id') id: string) {
        return this.appointmentService.confirmAppointment(req.user, id)
    }

    @UseGuards(AuthGuard("jwt"))
    @Patch(':id/cancel')
    async cancelAppointment(@Req() req: any, @Param('id') id: string) {
        return this.appointmentService.cancelAppointment(req.user, id)
    }

    @UseGuards(AuthGuard("jwt"))
    @Patch(':id/finish')
    async finishAppointment(@Req() req: any, @Param('id') id: string) {
        return this.appointmentService.finishAppointment(req.user, id)
    }

}
