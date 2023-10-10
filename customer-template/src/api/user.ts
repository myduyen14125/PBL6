import httpRequest from "../ultils/httpRequest";

export const getUserInfo = async (id: string): Promise<any> =>
  httpRequest.get<any>(`/user/${id}`);
