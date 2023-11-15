import { Schema, Document } from "mongoose";
import { Expertise } from "src/expertise/expertise.model";

const UserSchema = new Schema(
    {
        name: String,
        avatar: String,
        email: String,
        password: String,
        date_of_birth: Date,
        gender: Boolean,
        phone: String,
        facebook_link: String,
        skype_link: String,     
        number_of_mentees: Number,
        role: String,
        refreshToken: String,
        expertise: { type: Schema.Types.ObjectId, ref: 'Expertise' },
    },
    {
        collection: 'users',
        toObject: {virtuals: true}
    }
)

UserSchema.virtual('bio', {
    ref: 'Bio',
    localField: '_id',
    foreignField: 'user',
    justOne: true,
});

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


UserSchema.virtual('appointments', {
    ref: 'Appointment',
    localField: '_id',
    foreignField: 'user',
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
    facebook_link: string;
    skype_link: string;
    expertise: Expertise
    role: string;
    number_of_mentees: number;
    refreshToken: string;
}