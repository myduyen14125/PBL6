import httpRequest from "../ultils/httpRequest";

export const getAllUserAppointment = async (): Promise<any> =>
  httpRequest.get<any>("/appointment");

export const createAppointment = async (data: any): Promise<any> =>
  httpRequest.post<any>("/appointment", data);

export const confirmAppointment = async (id: string): Promise<any> =>
  httpRequest.patch<any>(`/appointment/${id}/confirm`);
