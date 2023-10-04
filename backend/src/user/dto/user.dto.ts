import { IsEmail, IsNotEmpty, Length, Min, MinLength } from "class-validator";

export class CreateUserDto {


    @IsNotEmpty() first_name: string;
    @IsNotEmpty() last_name: string;
    @IsNotEmpty() avatar: string;

    @IsEmail()
    @IsNotEmpty()
    email: string;


    @MinLength(6)
    @IsNotEmpty() password: string;

    @IsNotEmpty() date_of_birth: Date;

    @MinLength(9)
    @IsNotEmpty() phone: string;

    @IsNotEmpty() gender: boolean;

    @IsNotEmpty()
    role: string;

    facebook_link: string;
    skype_link: string;

}

export class LoginUserDto {
    @IsEmail()
    @IsNotEmpty()
    email: string;

    @IsNotEmpty() password: string;
}