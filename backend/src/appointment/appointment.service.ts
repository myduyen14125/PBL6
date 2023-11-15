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
        const mentor = await this.userService.checkMentor(appointment.mentor)
        const schedule = await this.scheduleService.getScheduleById(appointment.schedule)
        if(!mentor) throw new HttpException('Mentor with the provided ID does not exist', HttpStatus.BAD_REQUEST);
        if(!schedule) throw new HttpException('Schedule with the provided ID does not exist', HttpStatus.BAD_REQUEST);
        if(!schedule.status) throw new HttpException('Schedule is already taken', HttpStatus.BAD_REQUEST);
        if(schedule.deleted) throw new HttpException('Schedule is already deleted', HttpStatus.BAD_REQUEST);
        if(appointment.mentor != schedule.user.toString()) throw new HttpException('Mentor and Schedule Mismatched', HttpStatus.BAD_REQUEST);

        appointment.mentee = mentee._id;
        appointment.mentor = appointment.mentor;
        appointment.status = "pending";

        const newAppointment = await this.appointmentRepository.create(appointment);
        await newAppointment.populate({ path: 'mentee', select: 'name avatar email' });
        await newAppointment.populate({ path: 'mentor', select: 'name avatar email' });
        await newAppointment.populate({ path: 'schedule' });

        await this.scheduleService.updateScheduleStatus(appointment.schedule, false)
            //         // mail to mentor
    //         const mentor = await this.userService.getUserById(appointment.mentor)
    //         await this.mailerService.sendMail({
    //             to: mentor.email,
    //             subject: 'You have a new pending appointment!',
    //             template: `./bookappointment`,
    //             context: {
    //                 mentee: mentee.name,
    //                 mentor: mentor.name
    //             }
    //         })
        
        return newAppointment
    }

    async getAllUsersAppointments(user_id: string, page:number, limit:number = 6) {
        const count = await this.appointmentRepository.countDocuments({$or: [{ mentee: user_id }, { mentor: user_id }]})
        const countPage = Math.ceil(count / limit)
        const skip = (page - 1) * limit || 0
        const oldAppointments = await this.appointmentRepository.getByCondition({$or: [{ mentee: user_id }, { mentor: user_id }]})

        const currentDate = new Date();
        currentDate.setHours(currentDate.getHours() +7);

        await Promise.all(oldAppointments.map(async (appointment) => {
            await appointment.populate({ path: 'schedule' });
            if (appointment.schedule.start_at < currentDate) {
                if (appointment.status === "pending") {
                    await this.appointmentRepository.findByIdAndUpdate(appointment.id, { status: "canceled" })
                }
            }
            if (appointment.schedule.start_at < currentDate) {
                if (appointment.status === "confirmed") {
                    await this.appointmentRepository.findByIdAndUpdate(appointment.id, { status: "finished" })
                }
            }
        }));

        const appointments = await this.appointmentRepository.aggregate([
            {
                $match: {
                    $or: [{ mentee: user_id }, { mentor: user_id }]
                },
            },
            {
                $lookup: {
                    from: 'schedules',
                    localField: 'schedule',
                    foreignField: '_id',
                    as: 'schedule'
                }
            }, 
            {
                $unwind: '$schedule'
            },
            {
                $sort: {
                    'schedule.start_at': 1
                }
            },
            {
                $skip: skip
            },
            {
                $limit: Number(limit)
            },
            {
                $lookup: {
                    from: 'users',
                    localField: 'mentee',
                    foreignField: '_id',
                    as: 'mentee'
                }
            },
            {
                $lookup: {
                    from: 'users',
                    localField: 'mentor',
                    foreignField: '_id',
                    as: 'mentor'
                }
            },
            {
                $unwind: '$mentee'
            },
            {
                $unwind: '$mentor'
            },
            {
                $lookup: {
                    from: 'expertises', 
                    localField: 'mentor.expertise',
                    foreignField: '_id',
                    as: 'mentor.expertise'
                }
            },
            {
                $unwind: '$mentor.expertise'
            },
            {
                $project: {
                    _id: 1,
                    schedule: 1,
                    mentee: {
                        name: '$mentee.name',
                        avatar: '$mentee.avatar',
                        email: '$mentee.email'
                    },
                    mentor: {
                        name: '$mentor.name',
                        avatar: '$mentor.avatar',
                        skype_link: '$mentor.skype_link',
                        facebook_link: '$mentor.facebook_link',
                        expertise: {
                            name: '$mentor.expertise.name'
                        }
                    },
                    note: '$note',
                    status: '$status'
                }
            },
        ])

        return {
            count, countPage, appointments
        }
    }

    async getAppointmentById(user: User, id: string) {
        const appointment = await this.appointmentRepository.findById(id);
        if (appointment.mentee.equals(user._id) || appointment.mentor.equals(user._id)) {
            await appointment.populate({ path: 'mentee', select: 'name avatar' });
            await appointment.populate({ path: 'mentor', select: 'name avatar skype_link facebook_link expertise',populate: {path: 'expertise',select: 'name'}, });
            await appointment.populate({ path: 'schedule' });

            return appointment
        } else {
            throw new HttpException('Only participants can view this appointment', HttpStatus.BAD_REQUEST);
        }
    }

    // unused function
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
        const updatedAppointment = await this.appointmentRepository.findByIdAndUpdate(id, {status: "confirmed"})
        await updatedAppointment.populate({ path: 'mentee', select: 'name avatar' });
        await updatedAppointment.populate({ path: 'mentor', select: 'name avatar skype_link facebook_link expertise',populate: {path: 'expertise',select: 'name'}, });
        await updatedAppointment.populate({ path: 'schedule' });

        // mail to mentee
        const mentee = await this.userService.getUserById(oldAppointment.mentee._id)
        // await this.mailerService.sendMail({
        //     to: mentee.email,
        //     subject: 'A mentor has confirmed your appointment!',
        //     template: `./confirmappointment`,
        //     context: {
        //         mentee: mentee.name,
        //         mentor: mentor.name
        //     }
        // })
        return updatedAppointment;
    }


    // cancel - mentee
    async cancelAppointment(mentee: User, id: string) {
        const oldAppointment = await this.appointmentRepository.findById(id)
        if (oldAppointment.status !== "pending") throw new HttpException('Status must be pending', HttpStatus.BAD_REQUEST);

        const updatedAppointment = await this.appointmentRepository.findByIdAndUpdate(id, {
            status: "canceled"
        })
        await updatedAppointment.populate({ path: 'mentee', select: 'name avatar' });
        await updatedAppointment.populate({ path: 'mentor', select: 'name avatar skype_link facebook_link expertise',populate: {path: 'expertise',select: 'name'}, });
        await updatedAppointment.populate({ path: 'schedule' });
        
        // free schedule
        await this.scheduleService.updateScheduleStatus(oldAppointment.schedule._id, true)

        // mail to mentor
        const mentor = await this.userService.getUserById(oldAppointment.mentor._id)
        // await this.mailerService.sendMail({
        //     to: mentor.email,
        //     subject: 'An appointment has been canceled!',
        //     template: `./cancelappointment`,
        //     context: {
        //         mentee: mentee.name,
        //         mentor: mentor.name
        //     }
        // })

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
