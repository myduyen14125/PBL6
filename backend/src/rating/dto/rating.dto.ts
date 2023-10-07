import { IsNotEmpty, IsIn } from "class-validator";

export class CreateRatingDto {

    mentee: string;

    @IsNotEmpty()
    mentor: string;

    @IsNotEmpty()
    comment: string;


    @IsNotEmpty()
    appointment: string;

    @IsIn([1, 2, 3, 4, 5])
    @IsNotEmpty()
    stars: number;
}
