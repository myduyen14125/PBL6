import { Schema, Document } from "mongoose";

const ExperienceSchema = new Schema({
    position: String,
    company: String,
    start_date: Date,
    end_date: Date,
});

const EducationSchema = new Schema({
    place: String,
    major: String,
    start_date: Date,
    end_date: Date,

});

const BioSchema = new Schema(
    {
        intro: String,
        experiences: [{ type: Schema.Types.ObjectId, ref: 'Experience' }],
        education: {
            type: Schema.Types.ObjectId,
            ref: 'Education'
        },
    },
    {
        timestamps: true,
        collection: "bios",
    }
);

export { BioSchema };

export interface Experience extends Document {
    position: string;
    company: string;
    start_date: Date;
    end_date: Date;
}

export interface Bio extends Document {
    intro: string;
    experiences: Experience[];
}
