import { Schema, Document } from "mongoose";
import { User } from "src/user/models/user.model";

const AppointmentSchema = new Schema(
    {
        note: String,
        mentee: {
            type: Schema.Types.ObjectId,
            ref: 'User'
        },

        mentor: {
            type: Schema.Types.ObjectId,
            ref: 'User'
        },

        start_at: Date,
        end_at: Date,
        status: String

    },
    {
        timestamps: true,
        collection: 'appointments',

    }
)

export { AppointmentSchema };
export interface Appointment extends Document {
    note: string;
    mentee: User;
    mentor: User;
    start_at: Date;
    end_at: Date;
    status: String;
}