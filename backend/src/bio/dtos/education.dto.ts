import { IsNotEmpty } from "class-validator";

export class CreateEducationDto {
    @IsNotEmpty() bio: string;
    @IsNotEmpty() place: string;
    @IsNotEmpty() major: string;
    @IsNotEmpty() start_date: Date;
    @IsNotEmpty() end_date: Date;
    description: string;
}

export class UpdateEducationDto {
    id: string;
    @IsNotEmpty() place: string;
    @IsNotEmpty() major: string;
    @IsNotEmpty() start_date: Date;
    @IsNotEmpty() end_date: Date;
    description: string;
}
