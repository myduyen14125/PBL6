import { IsNotEmpty } from "class-validator";

export class CreateBioDto {
    user: any;
}

export class UpdateBioDto {
    id: string;
    intro: string;
    experiences: [string];
    skills: [string];
    awards: [string];
    educations: [string];
}
