import { Document, Schema } from "mongoose";
import { User } from "src/user/models/user.model";

const BioSchema = new Schema(
    {
        intro: String,
        user: { type: Schema.Types.ObjectId, ref: 'User' },
    },
    {
        timestamps: true,
        collection: "bios",
    }
);

export { BioSchema };

export interface Bio extends Document {
    intro: string;
    user: User;
}
