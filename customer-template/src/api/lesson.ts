import httpRequest from "../ultils/httpRequest";

export const getLessonsById = async (id: string): Promise<any> =>
  httpRequest.get<any>(`/lesson/${id}`);

export const createLesson = async (params: any): Promise<any> =>
  httpRequest.post("/lesson", params);

export const deleteLesson = async (id: string): Promise<any> =>
  httpRequest.delete<any>(`/lesson/${id}`);

export const updateLesson = async (id: string, params: any): Promise<any> =>
  httpRequest.patch<any>(`/lesson/${id}`, params);
