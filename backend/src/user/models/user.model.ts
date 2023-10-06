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

UserSchema.virtual('blogs',
    {
        ref: 'Blog',
        localField: '_id',
        foreignField: 'user',
        justOne: false,
    }
)


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