import { MailerService } from '@nestjs-modules/mailer';
import { HttpException, HttpStatus, Injectable } from "@nestjs/common";
import { ScheduleService } from "src/schedule/schedule.service";
import { User } from "src/user/user.model";
import { UserService } from "src/user/user.service";
import { CreateAppointmentDto, UpdateAppointmentDto } from "./appointment.dto";
import { AppointmentRepository } from "./appointment.repository";


@Injectable()
export class AppointmentService {
    constructor(
        private readonly appointmentRepository: AppointmentRepository,
        private readonly userService: UserService,
        private readonly scheduleService: ScheduleService,
        private mailerService: MailerService
    ) { }


    async createAppointment(mentee: User, appointment: CreateAppointmentDto) {
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

            // mail to mentor
            const mentor = await this.userService.getUserById(appointment.mentor)
            await this.mailerService.sendMail({
                to: mentor.email,
                subject: 'You have a new pending appointment!',
                template: `./bookappointment`,
                context: {
                    mentee: mentee.name,
                    mentor: mentor.name
                }
            })
            return populatedAppointment
        } else {
            throw new HttpException('Mentor with the provided ID does not exist', HttpStatus.BAD_REQUEST);
        }
    }

    async getAllUsersAppointments(user_id: string) {

        const appointments = await this.appointmentRepository.getByCondition({
            $or: [{ mentee: user_id }, { mentor: user_id }]
        })

        await Promise.all(appointments.map(async (appointment) => {
            // await appointment.populate({ path: 'mentee', select: '-password -refreshToken -date_of_birth' });
            // await appointment.populate({ path: 'mentor', select: '-password -refreshToken -date_of_birth' });
            await appointment.populate({ path: 'schedule' });
            // console.log(appointment);
            // console.log(appointment.schedule.start_at);
            // console.log(appointment.status);
            // console.log(new Date());
            // if (appointment.schedule.start_at < new Date()) console.log("yes");



            if (appointment.schedule.start_at < (new Date())) {
                if (appointment.status === "pending") {
                    await this.appointmentRepository.findByIdAndUpdate(appointment.id, { status: "canceled" }
                    )
                }
            }
            if (appointment.schedule.start_at < (new Date())) {
                if (appointment.status === "confirmed") {
                    await this.appointmentRepository.findByIdAndUpdate(appointment.id, { status: "finished" }
                    )
                }
            }
        }));

        const renewAppointments = await this.appointmentRepository.getByCondition({
            $or: [{ mentee: user_id }, { mentor: user_id }]
        })

        await Promise.all(renewAppointments.map(async (appointment) => {
            await appointment.populate({ path: 'mentee', select: '-password -refreshToken -date_of_birth' });
            await appointment.populate({ path: 'mentor', select: '-password -refreshToken -date_of_birth' });
            await appointment.populate({ path: 'schedule' });
            // console.log(appointment);
            // console.log(appointment.schedule.start_at);
            // console.log(appointment.status);
            // console.log(new Date());
            // if (appointment.schedule.start_at < new Date()) console.log("yes");

        }));
        // console.log(appointments);


        return renewAppointments


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

    async updateRatedAppointment(id: string, newStatus: string) {
        return await this.appointmentRepository.findByIdAndUpdate(id, {
            status: newStatus
        })
    }

    // confirm - mentor
    async confirmAppointment(mentor: User, id: string) {
        const oldAppointment = await this.appointmentRepository.findById(id)
        if (oldAppointment.status !== "pending") throw new HttpException('Status must be pending', HttpStatus.BAD_REQUEST);
        // if (!(await this.userService.checkMentor(mentor._id))) throw new HttpException('Only mentors can confirm an appointment', HttpStatus.BAD_REQUEST);
        const updatedAppointment = await this.appointmentRepository.findByIdAndUpdate(id, {
            status: "confirmed"
        })
        await updatedAppointment.populate({ path: 'mentee', select: '-password -refreshToken -date_of_birth' });
        await updatedAppointment.populate({ path: 'mentor', select: '-password -refreshToken -date_of_birth' });
        await updatedAppointment.populate({ path: 'schedule' });


        // mail to mentee
        const mentee = await this.userService.getUserById(oldAppointment.mentee._id)
        await this.mailerService.sendMail({
            to: mentee.email,
            subject: 'A mentor has confirmed your appointment!',
            template: `./confirmappointment`,
            context: {
                mentee: mentee.name,
                mentor: mentor.name
            }
        })
        return updatedAppointment;
    }


    // cancel - mentee
    async cancelAppointment(mentee: User, id: string) {
        const oldAppointment = await this.appointmentRepository.findById(id)
        if (oldAppointment.status !== "pending") throw new HttpException('Status must be pending', HttpStatus.BAD_REQUEST);

        const updatedAppointment = await this.appointmentRepository.findByIdAndUpdate(id, {
            status: "canceled"
        })
        await updatedAppointment.populate({ path: 'mentee', select: '-password -refreshToken -date_of_birth' });
        await updatedAppointment.populate({ path: 'mentor', select: '-password -refreshToken -date_of_birth' });
        await updatedAppointment.populate({ path: 'schedule' });
        // free schedule
        await this.scheduleService.updateScheduleStatus(oldAppointment.schedule._id, true)

        // mail to mentor
        const mentor = await this.userService.getUserById(oldAppointment.mentor._id)
        await this.mailerService.sendMail({
            to: mentor.email,
            subject: 'An appointment has been canceled!',
            template: `./cancelappointment`,
            context: {
                mentee: mentee.name,
                mentor: mentor.name
            }
        })

        return updatedAppointment;

    }

    // finished - mentor
    async finishAppointment(mentor: User, id: string) {
        const oldAppointment = await this.appointmentRepository.findById(id)
        if (oldAppointment.status !== "confirmed") throw new HttpException('Status must be confirmed', HttpStatus.BAD_REQUEST);

        // if (!(await this.userService.checkMentor(mentor._id))) throw new HttpException('Only mentors can finish an appointment', HttpStatus.BAD_REQUEST);
        const updatedAppointment = await this.appointmentRepository.findByIdAndUpdate(id, {
            status: "finished"
        })
        await updatedAppointment.populate({ path: 'mentee', select: '-password -refreshToken -date_of_birth' });
        await updatedAppointment.populate({ path: 'mentor', select: '-password -refreshToken -date_of_birth' });
        await updatedAppointment.populate({ path: 'schedule' });

        // update number of mentee
        await this.userService.updateUserNumberOfMentees(mentor._id);
        // mail


        return updatedAppointment;

    }



}
