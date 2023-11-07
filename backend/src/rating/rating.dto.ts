import { IsNotEmpty, IsIn } from "class-validator";

export class CreateRatingDto {

    mentee: string;
    mentor: string;

    @IsNotEmpty()
    comment: string;


    @IsNotEmpty()
    appointment: string;

    @IsIn([1, 2, 3, 4, 5])
    @IsNotEmpty()
    stars: number;
}

export class PaginationRatingDto {
    @IsNotEmpty()
    page: number;
    @IsNotEmpty()
    limit: number;
}
