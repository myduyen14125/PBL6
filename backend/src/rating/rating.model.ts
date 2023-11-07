import { Schema, Document } from "mongoose";
import { User } from "src/user/user.model";

const RatingSchema = new Schema(
    {
        comment: String,
        mentee: {
            type: Schema.Types.ObjectId,
            ref: 'User'
        },

        mentor: {
            type: Schema.Types.ObjectId,
            ref: 'User'
        },


        appointment: {
            type: Schema.Types.ObjectId,
            ref: 'Appointment'
        },

        stars: Number,

    },
    {
        timestamps: true,
        collection: 'ratings',

    }
)

export { RatingSchema };
export interface Rating extends Document {
    comment: string;
    mentee: User;
    mentor: User;
    stars: number;
}