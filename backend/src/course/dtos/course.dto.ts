import { IsNotEmpty } from "class-validator";

export class CreateCourseDto {
    creator: any
    @IsNotEmpty()
    title: string
    @IsNotEmpty()
    description: string
    @IsNotEmpty()
    price: number
    @IsNotEmpty()
    image: string
}

export class UpdateCourseDto {
    title: string
    description: string
    price: number
    discount: number
    image: string
    user: string
}

export class PaginationCourseDto {
    @IsNotEmpty()
    page: number;
    @IsNotEmpty()
    limit: number;
}