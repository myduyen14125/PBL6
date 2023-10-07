import { IsNotEmpty, IsMongoId, IsIn } from "class-validator";

export class CreateAppointmentDto {

    // @IsMongoId()
    // @IsNotEmpty()
    mentee: string;

    // @IsMongoId()
    @IsNotEmpty()
    mentor: string;

    @IsNotEmpty()
    start_at: Date;

    @IsNotEmpty()
    end_at: Date;

    note: string;

    @IsIn(['pending', 'confirmed', 'canceled', 'finished', 'rated'])
    @IsNotEmpty()
    status: string;
}

export class UpdateAppointmentDto {
    id: string;
    note: string;

    @IsIn(['pending', 'confirmed', 'canceled', 'finished', 'rated'])
    status: string;

    start_at: Date;

    end_at: Date;
}