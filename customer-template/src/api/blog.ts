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

export const deleteBlog = async (id: string): Promise<any> =>
  httpRequest.delete<any>(`/blog/${id}`);

export const updateBlog = async (
  id: string,
  params: CreateBlogParams
): Promise<any> => httpRequest.patch<any>(`/blog/${id}`, params);
