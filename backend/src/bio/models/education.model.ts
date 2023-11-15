import { Schema, Document } from "mongoose";
import { Bio } from "./bio.model";

const EducationSchema = new Schema({
    place: String,
    major: String,
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
        collection: "educations",
        toObject: {virtuals: true}
    });


export { EducationSchema };

export interface Education extends Document {
    place: string;
    major: string;
    description: string;
    start_date: Date;
    end_date: Date;
    bio: Bio
}
