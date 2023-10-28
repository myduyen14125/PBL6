import { User } from "./auth";
import { Schedule } from "./schedule";

export interface Appointment {
  _id: string;
  start_at: string;
  end_at: string;
  mentee: User;
  mentor: User;
  schedule: Schedule;
  status: string;
}

export interface CreateAppointmentParams {
  mentor: string;
  schedule: string;
  note: string;
}
