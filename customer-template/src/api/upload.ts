import httpRequest from "../ultils/httpRequest";

export const uploadMedia = async (media: any): Promise<any> => {
  const formData = new FormData();
  formData.append("media", media);
  return httpRequest.post<any>("/media/upload", formData);
}