import { IsNotEmpty } from "class-validator";

export class CreateSkillDto {
    @IsNotEmpty() bio: string;
    @IsNotEmpty() name: string;
    description: string;
}

export class UpdateSkillDto {
    id: string;
    @IsNotEmpty() name: string;
    description: string;
}
