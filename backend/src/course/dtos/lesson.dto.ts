import { IsNotEmpty } from "class-validator";

export class CreateLessonDto {
    @IsNotEmpty()
    title: string
    @IsNotEmpty()
    description: string
    @IsNotEmpty()
    image: string
    @IsNotEmpty()
    video: string
    order: Number
    @IsNotEmpty()
    course: string
}

export class UpdateLessonDto {
    title: string
    description: string
    image: string
    video: string
    order: Number
}

export class PaginationLessonDto {
    page: number;
    limit: number;
}