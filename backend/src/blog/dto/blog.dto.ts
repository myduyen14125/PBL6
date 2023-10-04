import { IsNotEmpty } from "class-validator";

export class CreateBlogDto {
    @IsNotEmpty() title: string;
    @IsNotEmpty() content: string;
    user: any;
}

export class UpdateBlogDto {
    id: string;
    @IsNotEmpty() title: string;
    @IsNotEmpty() content: string;
}