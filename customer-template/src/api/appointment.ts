import httpRequest from "../ultils/httpRequest";

export const getAllUserAppointment = async (): Promise<any> =>
  httpRequest.get<any>("/appointment");


