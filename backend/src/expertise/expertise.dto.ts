import { IsNotEmpty } from "class-validator";

export class CreateExpertiseDto {
    @IsNotEmpty() name: string;

}

export class UpdateExpertiseDto {
    id: string;
    @IsNotEmpty() name: string;
}
