import httpRequest from "../ultils/httpRequest";
import { SearchParams } from "../types/mentor";

export const getMentors = async (params: SearchParams): Promise<any> =>
  httpRequest.get<any>("/mentors", { params });
  

