import httpRequest from "../ultils/httpRequest";

export const refreshToken = async (params: any): Promise<any> =>
  httpRequest.post<any, any>("/token", params);
