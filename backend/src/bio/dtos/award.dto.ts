import { IsNotEmpty } from "class-validator";

export class CreateAwardDto {
    @IsNotEmpty() bio: string;
    @IsNotEmpty() name: string;
    @IsNotEmpty() date: Date;
    description: string;
}

export class UpdateAwardDto {
    id: string;
    @IsNotEmpty() name: string;
    @IsNotEmpty() date: Date;
    description: string;
}
