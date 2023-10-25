import { User } from "./auth";
export interface Blog {
  _id: string;
  title: string;
  content: string;
  user: User;
  [elem: string]: any;
}
export interface CreateBlogParams {
  title: string;
  content: string;
  image?: string;
}
