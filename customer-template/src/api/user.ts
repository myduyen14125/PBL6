import httpRequest from "../ultils/httpRequest";
import { GetPaginationParams } from "../types/mentor";

export const getUserInfo = async (id: string): Promise<any> =>
  httpRequest.get<any>(`/user/${id}`);

export const getUserBlogs = async (
  id: string,
  params: GetPaginationParams
): Promise<any> => httpRequest.get<any>(`/user/${id}/blogs`, { params });

export const getUserSchedules = async (id: string): Promise<any> =>
  httpRequest.get<any>(`/user/${id}/schedules`);
