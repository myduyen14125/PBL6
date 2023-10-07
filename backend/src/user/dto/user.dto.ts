import { IsEmail, IsIn, IsNotEmpty, Min, MinLength } from "class-validator";

export class CreateUserDto {


    @IsNotEmpty() name: string;
    avatar: string;

    @IsEmail()
    @IsNotEmpty()
    email: string;


    @MinLength(6)
    @IsNotEmpty() password: string;

    @IsNotEmpty() date_of_birth: Date;

    
    phone: string;

    @IsNotEmpty() gender: boolean;

    @IsIn(['mentor', 'mentee'])
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