import { Schema, Document } from "mongoose";
import { User } from "src/user/models/user.model";

const ChatSchema = new Schema(
    {
        participants: [{ type: Schema.Types.ObjectId, ref: 'User' }]
    },
    {
        timestamps: true,
        collection: 'chats',
    }
)

export { ChatSchema };
export interface Chat extends Document {
    participants: [User]
}