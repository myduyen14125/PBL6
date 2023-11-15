import { Schema, Document } from "mongoose";
import { User } from "src/user/user.model";

const BlogSchema = new Schema(
    {
        title: String,
        content: String,
        image: String,
        user: {
            type: Schema.Types.ObjectId,
            ref: 'User'
        },
    },
    {
        timestamps: true,
        collection: 'blogs',

    }
)

export { BlogSchema };
export interface Blog extends Document {
    title: string;
    content: string;
    user: User;
    image: String;
}