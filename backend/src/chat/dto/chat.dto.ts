import { IsNotEmpty } from "class-validator";

export class CreateChatDto {
    @IsNotEmpty()
    participants: string[];
    sender: string;
    seen: boolean;
}
