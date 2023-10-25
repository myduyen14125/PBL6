import { Schema, Document } from "mongoose";
import { Bio } from "./bio.model";

const SkillSchema = new Schema({
    name: String,
    description: String,
    bio: {
        type: Schema.Types.ObjectId,
        ref: 'Bio'
    },
},
    {
        timestamps: true,
        collection: "skills",
    });


export { SkillSchema };

export interface Skill extends Document {
    name: string;
    description: string;
    bio: Bio
}
