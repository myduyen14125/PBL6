import httpRequest from "../ultils/httpRequest";
import { GetPaginationParams } from "../types/mentor";
import { User, ChangePasswordParams } from "../types/auth";

export const getUserInfo = async (id: string): Promise<any> =>
  httpRequest.get<any>(`/user/${id}`);

export const getUserBlogs = async (
  id: string,
  params: GetPaginationParams
): Promise<any> => httpRequest.get<any>(`/blog/by-user/${id}`, { params });

export const getUserSchedules = async (id: string): Promise<any> =>
  httpRequest.get<any>(`/schedule/by-user/${id}`);

export const updateUser = async (params: User): Promise<any> =>
  httpRequest.patch<any>("/user", params);

export const uploadAvatar = async (avatar: any): Promise<any> => {
  const formData = new FormData();
  formData.append("avatar", avatar);
  httpRequest.patch<any>("/user/update-avatar", formData);
};

export const getMyProfile = async (): Promise<any> =>
  httpRequest.get<any>("/user/profile");

export const changePassword = async (
  params: ChangePasswordParams
): Promise<any> => httpRequest.patch<any>(`/user/change-password`, params);
