import { HttpException, HttpStatus, Injectable, NotFoundException } from "@nestjs/common";
import { AppointmentRepository } from "../repositories/appointment.repository";
import { User } from "src/user/models/user.model";
import { CreateAppointmentDto, UpdateAppointmentDto } from "../dto/appointment.dto";
import { UserRepository } from "src/user/repositories/user.repository";
import { ScheduleRepository } from "src/schedule/repositories/schedule.repository";

@Injectable()
export class AppointmentService {
    constructor(private readonly appointmentRepository: AppointmentRepository,
        private readonly userRepository: UserRepository,
        private readonly scheduleRepository: ScheduleRepository,

    ) { }

    async checkMentor(mentor_id: string) {
        const mentor = await this.userRepository.findById(mentor_id);
        if (mentor && mentor.role == "mentor") {
            return true
        }
        return false
    }

    async checkMentee(mentee_id: string) {
        const mentor = await this.userRepository.findById(mentee_id);
        if (mentor && mentor.role == "mentee") {
            return true
        }
        return false

    }

    async createAppointment(mentee: User, appointment: CreateAppointmentDto) {
        if (await this.checkMentee(mentee._id)) {
            const mentorExists = await this.checkMentor(appointment.mentor);
            // console.log(appointment.mentor);

            if (mentorExists) {

                // check if schedule is taken
                const schedule = await this.scheduleRepository.findById(appointment.schedule)
                if (!schedule.status) throw new HttpException('Schedule is already taken', HttpStatus.BAD_REQUEST);

                appointment.mentee = mentee._id;
                appointment.mentor = appointment.mentor;
                appointment.status = "pending";
                const populatedAppointment = await this.appointmentRepository.create(appointment);
                await populatedAppointment.populate({ path: 'mentee', select: '-password -refreshToken -date_of_birth' });
                await populatedAppointment.populate({ path: 'mentor', select: '-password -refreshToken -date_of_birth' });
                await populatedAppointment.populate({ path: 'schedule' });

                // update schedule status
                await this.scheduleRepository.findByIdAndUpdate(appointment.schedule, {
                    status: false
                })

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
            throw new NotFoundException("Only participants can view this appointment");
        }
    }


    async updateAppointment(mentor: User, id: string, appointment: UpdateAppointmentDto) {
        if (await this.checkMentor(mentor._id)) {
            const oldAppointment = await this.appointmentRepository.findById(id)
            const updatedAppointment = await this.appointmentRepository.findByIdAndUpdate(id, appointment)
            await updatedAppointment.populate({ path: 'mentee', select: '-password -refreshToken -date_of_birth' });
            await updatedAppointment.populate({ path: 'mentor', select: '-password -refreshToken -date_of_birth' });
            await updatedAppointment.populate({ path: 'schedule' });

            // free up schedule
            if (appointment.status === "canceled") {
                await this.scheduleRepository.findByIdAndUpdate(oldAppointment.schedule, {
                    status: true
                })
            }

            return updatedAppointment;

        }
        else {
            throw new NotFoundException("Only mentors can modify an appointment");
        }
    }
}
