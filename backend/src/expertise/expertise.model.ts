import { Schema, Document } from "mongoose";

const ExpertiseSchema = new Schema(
    {
        name: String,
    },
    {
        timestamps: true,
        collection: 'expertises',

    }
)


export { ExpertiseSchema };
export interface Expertise extends Document {
    name: string;
}