import { Schema, Document } from "mongoose";

const UserSchema = new Schema(
    {
        name: String,
        avatar: String,
        email: String,
        password: String,
        date_of_birth: Date,
        gender: Boolean,
        phone: String,
        role: String,

        facebook_link: String,
        skype_link: String,

        refreshToken: String,

    },
    {
        collection: 'users',
    }
)

UserSchema.virtual('blogs', {
    ref: 'Blog',
    localField: '_id',
    foreignField: 'user',
    justOne: false,
});

UserSchema.virtual('schedules', {
    ref: 'Schedule',
    localField: '_id',
    foreignField: 'user',
    justOne: false,
});


UserSchema.virtual('mentorAppointments', {
    ref: 'Appointment',
    localField: '_id',
    foreignField: 'mentor',
    justOne: false,
});

// Virtual field for mentee appointments
UserSchema.virtual('menteeAppointments', {
    ref: 'Appointment',
    localField: '_id',
    foreignField: 'mentee',
    justOne: false,
});

UserSchema.virtual('ratings', {
    ref: 'Rating',
    localField: '_id',
    foreignField: 'mentor',
    justOne: false,
});



export { UserSchema };
export interface User extends Document {
    name: string;
    avatar: string;
    email: string;
    password: string;
    date_of_birth: Date;
    gender: boolean;
    phone: string;
    role: string;

    facebook_link: string;
    skype_link: string;


    refreshToken: string;

}