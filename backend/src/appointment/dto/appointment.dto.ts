import { IsNotEmpty, IsMongoId, IsIn } from "class-validator";

export class CreateAppointmentDto {

    // @IsMongoId()
    // @IsNotEmpty()
    mentee: string;

    // @IsMongoId()
    @IsNotEmpty()
    mentor: string;

    @IsNotEmpty()
    schedule: string

    note: string;

    // @IsIn(['pending', 'confirmed', 'canceled', 'finished', 'rated'])
    status: string;
}

export class UpdateAppointmentDto {
    id: string;
    note: string;

    @IsIn(['confirmed', 'canceled', 'finished', 'rated'])
    status: string;
}