import { HttpException, HttpStatus, Injectable, NotFoundException, forwardRef, Inject } from "@nestjs/common";
import { CreateAppointmentDto, UpdateAppointmentDto } from "../dto/appointment.dto";
import { AppointmentRepository } from "../repositories/appointment.repository";
import { User } from "src/user/models/user.model";
import { ScheduleService } from "src/schedule/services/schedule.service";
import { UserService } from "src/user/services/user.service";


@Injectable()
export class AppointmentService {
    constructor(
        private readonly appointmentRepository: AppointmentRepository,
        private readonly userService: UserService,
        private readonly scheduleService: ScheduleService,

    ) { }


    async createAppointment(mentee: User, appointment: CreateAppointmentDto) {
        if (await this.userService.checkMentee(mentee._id)) {
            const mentorExists = await this.userService.checkMentor(appointment.mentor);
            // console.log(appointment.mentor);

            if (mentorExists) {

                // check if schedule is taken
                const schedule = await this.scheduleService.getScheduleById(mentee, appointment.schedule)
                const { ObjectId } = require('mongodb')
                // console.log(schedule);
                console.log(schedule.user);
                console.log(new ObjectId(appointment.mentor));

                if (!schedule.user.equals(new ObjectId(appointment.mentor))) throw new HttpException('Invalid schedule', HttpStatus.BAD_REQUEST);

                if (!schedule.status) throw new HttpException('Schedule is already taken', HttpStatus.BAD_REQUEST);

                appointment.mentee = mentee._id;
                appointment.mentor = appointment.mentor;
                appointment.status = "pending";
                const populatedAppointment = await this.appointmentRepository.create(appointment);
                await populatedAppointment.populate({ path: 'mentee', select: '-password -refreshToken -date_of_birth' });
                await populatedAppointment.populate({ path: 'mentor', select: '-password -refreshToken -date_of_birth' });
                await populatedAppointment.populate({ path: 'schedule' });

                // update schedule status
                await this.scheduleService.updateScheduleStatus(appointment.schedule, false)

                return populatedAppointment
            } else {
                throw new HttpException('Mentor with the provided ID does not exist', HttpStatus.BAD_REQUEST);
            }
        }
        else {
            throw new HttpException('Only mentees can book an appointment', HttpStatus.BAD_REQUEST);
        }
    }

    async getAllUsersAppointments(user_id: string) {

        const appointments = await this.appointmentRepository.getByCondition({
            $or: [{ mentee: user_id }, { mentor: user_id }]
        })

        await Promise.all(appointments.map(async (appointment) => {
            await appointment.populate({ path: 'mentee', select: '-password -refreshToken -date_of_birth' });
            await appointment.populate({ path: 'mentor', select: '-password -refreshToken -date_of_birth' });
            await appointment.populate({ path: 'schedule' });

        }));

        return appointments
    }

    async getAppointmentById(user: User, id: string) {
        const appointment = await this.appointmentRepository.findById(id);
        if (appointment.mentee.equals(user._id) || appointment.mentor.equals(user._id)) {
            await appointment.populate({ path: 'mentee', select: '-password -refreshToken -date_of_birth' });
            await appointment.populate({ path: 'mentor', select: '-password -refreshToken -date_of_birth' });
            await appointment.populate({ path: 'schedule' });

            return appointment
        } else {
            throw new HttpException('Only participants can view this appointment', HttpStatus.BAD_REQUEST);
        }
    }


    async updateAppointment(mentor: User, id: string, appointment: UpdateAppointmentDto) {
        if (await this.userService.checkMentor(mentor._id)) {
            const oldAppointment = await this.appointmentRepository.findById(id)
            const updatedAppointment = await this.appointmentRepository.findByIdAndUpdate(id, appointment)
            await updatedAppointment.populate({ path: 'mentee', select: '-password -refreshToken -date_of_birth' });
            await updatedAppointment.populate({ path: 'mentor', select: '-password -refreshToken -date_of_birth' });
            await updatedAppointment.populate({ path: 'schedule' });

            // free up schedule
            if (appointment.status === "canceled") {
                await this.scheduleService.updateScheduleStatus(oldAppointment.schedule.id, true)
            }

            if (appointment.status === "confirmed") {
                await this.userService.updateUserNumberOfMentees(mentor._id);
            }
            return updatedAppointment;

        }
        else {
            throw new HttpException('Only mentors can modify an appointment', HttpStatus.BAD_REQUEST);
        }
    }
    /////////////////

    async updateRatedAppointment(id: string, newStatus: string) {
        return await this.appointmentRepository.findByIdAndUpdate(id, {
            status: newStatus
        })
    }
}
