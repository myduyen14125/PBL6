import { Chat } from "src/chat/models/chat.model";
import { Message } from "src/chat/models/message.model";

export interface ServerToClientEvents {
    newMessage: (payload: Message) => void;
    seenStatus: (payload: Chat) => void;
    joinStatus: (payload: String) => void;
}