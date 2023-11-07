import { Schema, Document } from "mongoose";
import { User } from "src/user/user.model";

const ChatSchema = new Schema(
    {
        participants: [{ type: Schema.Types.ObjectId, ref: 'User' }],
        latest_message: String,
        seen: Boolean,
        sender: { type: Schema.Types.ObjectId, ref: 'User' }
    },
    {
        timestamps: true,
        collection: 'chats',
    }
)

export { ChatSchema };
export interface Chat extends Document {
    participants: [User];
    latest_message: string;
    seen: boolean;
    sender: User;
}