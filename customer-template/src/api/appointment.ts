import httpRequest from "../ultils/httpRequest";
import { GetPaginationParams } from "../types/mentor";

export const getAllUserAppointment = async (params: GetPaginationParams): 
  Promise<any> => httpRequest.get<any>("/appointment", { params });

export const createAppointment = async (data: any): Promise<any> =>
  httpRequest.post<any>("/appointment", data);

export const confirmAppointment = async (id: string): Promise<any> =>
  httpRequest.patch<any>(`/appointment/${id}/confirm`);

export const cancelAppointment = async (id: string): Promise<any> =>
  httpRequest.patch<any>(`/appointment/${id}/cancel`);
