import { IsNotEmpty } from "class-validator";

export class CreateChatDto {
    @IsNotEmpty()
    participants: string[];
}

export class UpdateChatDto {

}
