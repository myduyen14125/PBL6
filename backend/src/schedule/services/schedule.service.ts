import { HttpException, HttpStatus, Injectable } from "@nestjs/common";
import { User } from "src/user/models/user.model";
import { ScheduleRepository } from "../repositories/schedule.repository";
import { CreateScheduleDto } from "../dto/schedule.dto";

@Injectable()
export class ScheduleService {
    constructor(private readonly scheduleRepository: ScheduleRepository,
    ) { }


    async createSchedule(user: User, schdule: CreateScheduleDto) {
        // mentor only
        if (user.role === "mentee") {
            return HttpStatus.BAD_REQUEST
        }
        schdule.user = user.id
        schdule.status = true
        // check valid date input
        if (schdule.start_at >= schdule.end_at) {
            throw new HttpException('Invalid Starttime/ Endtime', HttpStatus.BAD_REQUEST);
        }

        // get current user schedules
        let overlappingSchedules = await this.scheduleRepository.getByCondition({
            user: user.id,
            start_at: { $lt: schdule.end_at },
            end_at: { $gt: schdule.start_at }
        });

        if (overlappingSchedules.length > 0) {
            throw new HttpException('Invalid Starttime/ Endtime', HttpStatus.BAD_REQUEST);
        }
        return await this.scheduleRepository.create(schdule)

    }

    async createSchedules(user: User, schedules: CreateScheduleDto[]) {
        if (user.role === "mentee") {
            return HttpStatus.BAD_REQUEST;
        }

        const createdSchedules = [];

        for (const schedule of schedules) {
            schedule.user = user.id;
            schedule.status = true;

            if (schedule.start_at >= schedule.end_at) {
                throw new HttpException('Invalid Starttime/ Endtime', HttpStatus.BAD_REQUEST);
            }

            // get current user schedules
            let overlappingSchedules = await this.scheduleRepository.getByCondition({
                user: user.id,
                start_at: { $lt: schedule.end_at },
                end_at: { $gt: schedule.start_at }
            });

            if (overlappingSchedules.length > 0) {
                throw new HttpException('Invalid Starttime/ Endtime', HttpStatus.BAD_REQUEST);
            }
            const createdSchedule = await this.scheduleRepository.create(schedule);
            createdSchedules.push(createdSchedule);
        }

        return createdSchedules;
    }


    async getUserSchedule(user: User) {
        // console.log(user._id);

        const schedules = await this.scheduleRepository.getByCondition({
            user: user._id
        })
        return schedules
    }

    async getScheduleById(user: User, id: string) {
        const schedule = await this.scheduleRepository.findById(id);
        return schedule
    }

    ////////////////////////////////////
    async getAllSchedulesByUserId(id: string) {
        return await this.scheduleRepository.getByCondition({
            user: id
        })
    }

    async updateScheduleStatus(id: string, newStatus: boolean) {
        return await this.scheduleRepository.findByIdAndUpdate(id, {
            status: newStatus
        })
    }

}
