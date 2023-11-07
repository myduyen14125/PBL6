import { Schema, Document } from "mongoose";
import { Chat } from "./chat.model";
import { User } from "src/user/user.model";

const MessageSchema = new Schema(
    {
        text: String,
        sender: { type: Schema.Types.ObjectId, ref: 'User' },
        chat: { type: Schema.Types.ObjectId, ref: 'Chat' }
    },
    {
        timestamps: true,
        collection: 'messages',
    }
)

export { MessageSchema };
export interface Message extends Document {
    text: string;
    sender: User;
    chat: Chat
}