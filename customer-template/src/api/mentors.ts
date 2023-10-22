import httpRequest from "../ultils/httpRequest";
import {
  SearchParams,
  GetPaginationParams,
  SearchMentorsParams,
} from "../types/mentor";

export const getMentors = async (params: SearchParams): Promise<any> =>
  httpRequest.get<any>("/mentors", { params });

export const getMentorsPagination = async (
  params: GetPaginationParams
): Promise<any> => httpRequest.get<any>("/mentor", { params });

export const getSearchMentor = async (
  params: SearchMentorsParams
): Promise<any> => httpRequest.get<any>("/mentor/search", { params });
