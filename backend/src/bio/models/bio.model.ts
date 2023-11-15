import { Document, Schema } from "mongoose";
import { User } from "src/user/user.model";

const BioSchema = new Schema(
    {
        intro: String,
        user: { type: Schema.Types.ObjectId, ref: 'User' },
    },
    {
        timestamps: true,
        collection: "bios",
        toObject: {virtuals: true}
    }
);

BioSchema.virtual('awards', {
    ref: 'Award',
    localField: '_id',
    foreignField: 'bio',
    justOne: false,
});

BioSchema.virtual('skills', {
    ref: 'Skill',
    localField: '_id',
    foreignField: 'bio',
    justOne: false,
});


BioSchema.virtual('experiences', {
    ref: 'Experience',
    localField: '_id',
    foreignField: 'bio',
    justOne: false,
});


BioSchema.virtual('educations', {
    ref: 'Education',
    localField: '_id',
    foreignField: 'bio',
    justOne: false,
});

export { BioSchema };
export interface Bio extends Document {
    intro: string;
    user: User;
}
