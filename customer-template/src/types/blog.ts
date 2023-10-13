import { User } from "./auth";
export interface Blog {
  _id: string;
  title: string;
  content: string;
  user: User;
  [elem: string]: any;
}
