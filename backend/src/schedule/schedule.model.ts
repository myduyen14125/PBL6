import { Schema, Document } from "mongoose";
import { Appointment } from "src/appointment/appointment.model";
import { User } from "src/user/user.model";

const ScheduleSchema = new Schema(
    {
        start_at: Date,
        end_at: Date,
        user: {
            type: Schema.Types.ObjectId,
            ref: 'User'
        },
        status: Boolean,
        deleted: Boolean
    },
    {
        timestamps: true,
        collection: 'schedules',
    }
)

export { ScheduleSchema };
export interface Schedule extends Document {
    start_at: Date,
    end_at: Date,
    user: User
    status: boolean,
    deleted: boolean
}