import { Schema, Document } from "mongoose";
import { Education } from "./education.model";
import { Experience } from "./experience.model";
import { Skill } from "./skill.model";
import { Award } from "./award.model";
import { User } from "src/user/models/user.model";

const BioSchema = new Schema(
    {
        intro: String,
        user: { type: Schema.Types.ObjectId, ref: 'User' },
        // experiences: [{ type: Schema.Types.ObjectId, ref: 'Experience' }],
        // education: [{ type: Schema.Types.ObjectId, ref: 'Education' }],
        // skills: [{ type: Schema.Types.ObjectId, ref: 'Skill' }],
        // awards: [{ type: Schema.Types.ObjectId, ref: 'Award' }]
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
    // experiences: [Experience];
    // education: [Education];
    // skills: [Skill];
    // awards: [Award]
}
