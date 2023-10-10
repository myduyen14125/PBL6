import httpRequest from "../ultils/httpRequest";

export const getAllBlogs = async (): Promise<any> =>
  httpRequest.get<any>("/blog");
