import { User } from "./auth";

export interface Appointment {
  _id: string;
  start_at: string;
  end_at: string;
  user: User;
  status: boolean;
}