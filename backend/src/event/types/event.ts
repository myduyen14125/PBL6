import { Message } from "src/chat/models/message.model";

export interface ServerToClientEvents {
    newMessage: (payload: Message) => void;
}