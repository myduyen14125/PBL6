import { PostExperienceParams } from "./../types/bio";
import httpRequest from "../ultils/httpRequest";

export const createExperience = async (
  params: PostExperienceParams
): Promise<any> => httpRequest.post("/experience", params);

export const deleteExperience = async (id: string): Promise<any> =>
  httpRequest.delete<any>(`/experience/${id}`);

export const updateExperience = async (
  id: string,
  params: PostExperienceParams
): Promise<any> => httpRequest.patch<any>(`/experience/${id}`, params);
