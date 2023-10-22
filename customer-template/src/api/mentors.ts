import httpRequest from "../ultils/httpRequest";
import {
  SearchParams,
  CreateScheduleParams,
  GetPaginationParams,
  SearchMentorsParams,
} from "../types/mentor";

export const getMentors = async (params: SearchParams): Promise<any> =>
  httpRequest.get<any>("/mentors", { params });

export const getMentorsPagination = async (
  params: GetPaginationParams
): Promise<any> => httpRequest.get<any>("/mentor", { params });

export const getSearchMentor = async (
  params: SearchMentorsParams
): Promise<any> => httpRequest.get<any>("/mentor/search", { params });

export const createSchedule = async (
  params: CreateScheduleParams[]
): Promise<any> => httpRequest.post<any>("/schedule/create-schedules", params);
