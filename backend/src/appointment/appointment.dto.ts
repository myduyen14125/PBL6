import { IsNotEmpty, IsIn } from "class-validator";

export class CreateAppointmentDto {
    mentee: string;
    @IsNotEmpty() mentor: string;
    @IsNotEmpty() schedule: string
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
    @IsNotEmpty() page: number; 
    @IsNotEmpty() limit: number;
}