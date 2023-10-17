import httpRequest from "../ultils/httpRequest";
import { CreateBlogParams } from "./../types/blog";

export const getAllBlogs = async (): Promise<any> =>
  httpRequest.get<any>("/blog");

export const createBlog = async (params: CreateBlogParams): Promise<any> =>
  httpRequest.post("/blog", params);

export const getBlogById = async (id: string): Promise<any> =>
  httpRequest.get<any>(`/blog/${id}`);
