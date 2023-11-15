import { IsNotEmpty, MinLength } from "class-validator";

export class UpdatePasswordDto {
    @MinLength(6) @IsNotEmpty() new_password: string;
    @MinLength(6) @IsNotEmpty() old_password: string;
}