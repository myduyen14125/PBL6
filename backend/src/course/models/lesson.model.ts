import { Schema, Document } from "mongoose";
import { Course } from "src/course/models/course.model";

const LessonSchema = new Schema(
    {
        title: String,
        description: String,
        image: String,
        video: String,
        archived: Boolean,
        order: Number,
        course: { type: Schema.Types.ObjectId, ref: 'Course' }
    },
    {
        timestamps: true,
        collection: 'lessons',
    }
)

export { LessonSchema };
export interface Lesson extends Document {
    title: string
    description: string
    image: string
    video: string
    order: Number
    archived: boolean
    course: Course

}