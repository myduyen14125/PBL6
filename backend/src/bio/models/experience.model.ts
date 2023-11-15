import { Schema, Document } from "mongoose";
import { Bio } from "./bio.model";

const ExperienceSchema = new Schema({
    position: String,
    company: String,
    description: String,
    start_date: Date,
    end_date: Date,
    bio: {
        type: Schema.Types.ObjectId,
        ref: 'Bio'
    },
},
    {
        timestamps: true,
        collection: "experiences",
        toObject: {virtuals: true}
    });


export { ExperienceSchema };

export interface Experience extends Document {
    position: string;
    company: string;
    description: string;
    start_date: Date;
    end_date: Date;
    bio: Bio
}
