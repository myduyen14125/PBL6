import httpRequest from "../ultils/httpRequest";
import { CreateCourseParams } from "./../types/course";
import { GetPaginationParams } from "../types/mentor";

export const getAllCourses = async (
  params: GetPaginationParams
): Promise<any> => httpRequest.get<any>("/course", { params });

// For mentor
export const getCoursePagination = async (
  params: GetPaginationParams
): Promise<any> => httpRequest.get<any>("/course/my-courses", { params });

export const createCourse = async (params: CreateCourseParams): Promise<any> =>
  httpRequest.post("/course", params);

export const getCourseById = async (id: string): Promise<any> =>
  httpRequest.get<any>(`/course/${id}`);

export const deleteCourse = async (id: string): Promise<any> =>
  httpRequest.delete<any>(`/course/${id}`);

export const updateCourse = async (
  id: string,
  params: CreateCourseParams
): Promise<any> => httpRequest.patch<any>(`/course/${id}`, params);
