import { IsEmail, IsIn, IsMongoId, IsNotEmpty, IsUrl, MaxLength, MinLength, Validate } from "class-validator";
import { IsStrongPassword } from "../validators/password.validator";

export class CreateUserDto {
    @IsNotEmpty() name: string;
    @IsEmail() @IsNotEmpty() email: string;
    @MinLength(6) @IsNotEmpty() @MaxLength(20) password: string;
    @IsNotEmpty() date_of_birth: Date;
    @IsNotEmpty() gender: boolean;
    @IsIn(['mentor', 'mentee']) @IsNotEmpty() role: string;  
    phone: string;
    avatar: string;
    number_of_mentees: number;
    facebook_link: string;
    skype_link: string;
    expertise: string;
}

export class LoginUserDto {
    @IsEmail() @IsNotEmpty() email: string;
    @IsNotEmpty() @IsStrongPassword() password: string;
}

export class UpdateUserDto {
    @MaxLength(30) name: string;
    date_of_birth: Date;
    @IsUrl() avatar: string;
    @MinLength(9) @MaxLength(11) phone: string;
    gender: boolean;
    @IsUrl() facebook_link: string;
    @IsUrl() skype_link: string;
    @IsMongoId() expertise: string;
}

export class PaginationMentorDto {
    page: number;
    limit: number;
}