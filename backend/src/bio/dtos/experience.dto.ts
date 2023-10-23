import { IsNotEmpty } from "class-validator";

export class CreateExperienceDto {
    @IsNotEmpty() bio: string;
    @IsNotEmpty() position: string;
    @IsNotEmpty() company: string;
    @IsNotEmpty() start_date: Date;
    @IsNotEmpty() end_date: Date;
    description: string;
}

export class UpdateExperienceDto {
    id: string;
    @IsNotEmpty() position: string;
    @IsNotEmpty() company: string;
    @IsNotEmpty() start_date: Date;
    @IsNotEmpty() end_date: Date;
    description: string;
}
