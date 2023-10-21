import { Schema, Document } from "mongoose";
import { Chat } from "./chat.model";

const MessageSchema = new Schema(
    {
        text: String,
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
    chat: Chat
}