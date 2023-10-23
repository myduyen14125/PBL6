import httpRequest from "../ultils/httpRequest";
import { CreateScheduleParams } from "../types/mentor";

export const getMySchedules = async (): Promise<any> =>
  httpRequest.get<any>("/schedule");

export const createSchedule = async (
  params: CreateScheduleParams[]
): Promise<any> => httpRequest.post<any>("/schedule/create-schedules", params);
