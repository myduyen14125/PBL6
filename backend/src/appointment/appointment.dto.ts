import { IsNotEmpty, IsIn } from "class-validator";

export class CreateAppointmentDto {
    @IsNotEmpty() schedule: string
    mentor: string;
    mentee: string;
    note: string;
    status: string;
}

export class UpdateAppointmentDto {
    id: string;
    note: string;
    @IsIn(['confirmed', 'canceled', 'finished', 'rated'])
    status: string;
}

export class PaginationAppointmentDto {
    page: number; 
    limit: number;
}