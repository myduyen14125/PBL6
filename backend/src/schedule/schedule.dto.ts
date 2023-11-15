import { IsNotEmpty } from "class-validator";

export class CreateScheduleDto {
    @IsNotEmpty() start_at: Date;
    @IsNotEmpty() end_at: Date;
    deleted: boolean
    user: any;
    status: boolean
}

export class UpdateScheduleDto {
    id: string;
    @IsNotEmpty() start_at: Date;
    @IsNotEmpty() end_at: Date;
    status: boolean

}