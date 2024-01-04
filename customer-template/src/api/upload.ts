import httpRequest from "../ultils/httpRequest";

export const uploadMedia = async (file: any): Promise<any> => {
  const formData = new FormData();
  formData.append("file", file);
  return httpRequest.post<any>("/media/upload", formData);
}