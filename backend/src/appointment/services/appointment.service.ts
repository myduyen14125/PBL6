import { HttpStatus, Injectable, NotFoundException } from "@nestjs/common";
import { AppointmentRepository } from "../repositories/appointment.repository";
import { User } from "src/user/models/user.model";
import { CreateAppointmentDto, UpdateAppointmentDto } from "../dto/appointment.dto";
import { UserRepository } from "src/user/repositories/user.repository";

@Injectable()
export class AppointmentService {
    constructor(private readonly appointmentRepository: AppointmentRepository,
        private readonly userRepository: UserRepository
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
            console.log(appointment.mentor);

            if (mentorExists) {
                appointment.mentee = mentee._id;
                appointment.mentor = appointment.mentor;
                const populatedAppointment = await this.appointmentRepository.create(appointment);
                await populatedAppointment.populate({ path: 'mentee', select: '-password -refreshToken -date_of_birth' });
                await populatedAppointment.populate({ path: 'mentor', select: '-password -refreshToken -date_of_birth' });

                return populatedAppointment
            } else {
                throw new NotFoundException("Mentor with the provided ID does not exist.");
            }
        }
        else {
            throw new NotFoundException("Only mentees can book an appointment");
        }
    }

    async getAllUsersAppointments(user_id: string) {

        const appointments = await this.appointmentRepository.getByCondition({
            $or: [{ mentee: user_id }, { mentor: user_id }]
        })

        await Promise.all(appointments.map(async (appointment) => {
            await appointment.populate({ path: 'mentee', select: '-password -refreshToken -date_of_birth' });
            await appointment.populate({ path: 'mentor', select: '-password -refreshToken -date_of_birth' });
        }));

        return appointments
    }

    async getAppointmentById(user: User, id: string) {
        const appointment = await this.appointmentRepository.findById(id);
        if (appointment.mentee.equals(user._id) || appointment.mentor.equals(user._id)) {
            await appointment.populate({ path: 'mentee', select: '-password -refreshToken -date_of_birth' });
            await appointment.populate({ path: 'mentor', select: '-password -refreshToken -date_of_birth' });
            return appointment
        } else {
            throw new NotFoundException("Only participants can view this appointment");
        }


        return appointment


    }


    async updateAppointment(mentor: User, id: string, appointment: UpdateAppointmentDto) {
        if (await this.checkMentor(mentor._id)) {
            const updatedAppointment = await this.appointmentRepository.findByIdAndUpdate(id, appointment)
            await updatedAppointment.populate({ path: 'mentee', select: '-password -refreshToken -date_of_birth' });
            await updatedAppointment.populate({ path: 'mentor', select: '-password -refreshToken -date_of_birth' });
            return updatedAppointment;
        }
        else {
            throw new NotFoundException("Only mentors can modify an appointment");
        }
    }
}
