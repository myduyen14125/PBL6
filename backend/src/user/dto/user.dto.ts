import { IsBoolean, IsEmail, IsIn, IsMongoId, IsNotEmpty, IsUrl, MinLength } from "class-validator";

export class CreateUserDto {
    @IsNotEmpty() name: string;
    @IsEmail() @IsNotEmpty() email: string;
    @MinLength(6) @IsNotEmpty() password: string;
    @IsNotEmpty() date_of_birth: Date;
    @IsNotEmpty() @IsBoolean() gender: boolean;
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
    @MinLength(6) @IsNotEmpty() password: string;
}

export class UpdateUserDto {
    name: string;
    date_of_birth: Date;
    avatar: string;
    phone: string;
    gender: boolean;
    @IsUrl() facebook_link: string;
    @IsUrl() skype_link: string;
    @IsMongoId() expertise: string;
}
export class PaginationMentorDto {
    @IsNotEmpty() page: number;
    @IsNotEmpty() limit: number;
}