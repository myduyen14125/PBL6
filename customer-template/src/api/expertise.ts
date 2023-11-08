import httpRequest from "../ultils/httpRequest";

export const getAllExpertise = async (): Promise<any> =>
  httpRequest.get<any>("/expertise");
