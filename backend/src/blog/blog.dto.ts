import { IsNotEmpty } from "class-validator";

export class CreateBlogDto {
    @IsNotEmpty() title: string;
    @IsNotEmpty() content: string;
    image: string;
    user: any;
}

export class UpdateBlogDto {
    id: string;
    @IsNotEmpty() title: string;
    @IsNotEmpty() content: string;
    image: string
}

export class PaginationBlogDto {
    page: number; 
    limit: number;
}