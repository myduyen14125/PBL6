import { Schema, Document } from "mongoose";
import { Schedule } from "src/schedule/schedule.model";
import { User } from "src/user/user.model";

const AppointmentSchema = new Schema(
    {
        mentee: { type: Schema.Types.ObjectId, ref: 'User'},
        mentor: { type: Schema.Types.ObjectId, ref: 'User'},
        schedule: { type: Schema.Types.ObjectId, ref: 'Schedule'},
        note: String,
        status: String

    },
    {
        timestamps: true,
        collection: 'appointments',
    }
)

export { AppointmentSchema };
export interface Appointment extends Document {
    mentee: User;
    mentor: User;
    schedule: Schedule
    note: string;
    status: String;
}