import httpRequest from "../ultils/httpRequest";
import { CreateBlogParams } from "./../types/blog";
import { GetPaginationParams } from "../types/mentor";

export const getBlogPagination = async (
  params: GetPaginationParams
): Promise<any> => httpRequest.get<any>("/blog", { params });

export const createBlog = async (params: CreateBlogParams): Promise<any> =>
  httpRequest.post("/blog", params);

export const getBlogById = async (id: string): Promise<any> =>
  httpRequest.get<any>(`/blog/${id}`);
