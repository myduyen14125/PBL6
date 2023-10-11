import { HttpStatus, Injectable } from "@nestjs/common";
import { User } from "src/user/models/user.model";
import { ScheduleRepository } from "../repositories/schedule.repository";
import { CreateScheduleDto } from "../dto/schedule.dto";

@Injectable()
export class ScheduleService {
    constructor(private readonly scheduleRepository: ScheduleRepository,
    ) { }


    async createSchedule(user: User, schedule: CreateScheduleDto) {
        if (user.role === "mentee") {
            return HttpStatus.BAD_REQUEST
        }
        schedule.user = user.id
        schedule.status = true

        // console.log(schedule);

        return await this.scheduleRepository.create(schedule)
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


}
