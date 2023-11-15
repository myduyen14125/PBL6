import { Schema, Document } from "mongoose";
import { Bio } from "./bio.model";

const AwardSchema = new Schema({
    name: String,
    description: String,
    date: Date,
    bio: {
        type: Schema.Types.ObjectId,
        ref: 'Bio'
    },
},
    {
        timestamps: true,
        collection: "awards",
        toObject: {virtuals: true}
    });


export { AwardSchema };

export interface Award extends Document {
    name: string;
    description: string;
    date: Date;
    bio: Bio
}
