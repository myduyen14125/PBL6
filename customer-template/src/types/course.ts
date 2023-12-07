import { User } from "./auth";
export interface Course {
  _id: string;
  title: string;
  description: string;
  price: number;
  discount?: number;
  image: string;
  creator: User;
}
export interface CreateCourseParams {
  title: string;
  description: string;
  price: number;
  discount?: number;
  image: string;
}
