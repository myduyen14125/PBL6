import { MinLength } from "class-validator";
import { IsStrongPassword } from "../validators/password.validator";

export class UpdatePasswordDto {
    @MinLength(6) @IsStrongPassword() new_password: string;
    @MinLength(6) @IsStrongPassword() old_password: string;
}