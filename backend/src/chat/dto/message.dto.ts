import { IsNotEmpty } from "class-validator";

export class CreateMessageDto {
    @IsNotEmpty()
    text: string;
    @IsNotEmpty()
    chat: string;
    sender: string;
}
