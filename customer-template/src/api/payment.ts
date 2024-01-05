import httpRequest from "../ultils/httpRequest";
import { BuyCourseParams } from "./../types/course";

export const buyCourse = async (params: BuyCourseParams): Promise<any> =>
  httpRequest.post<any>("/payment", params);
