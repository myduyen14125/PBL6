import httpRequest from "../ultils/httpRequest";
import { SignInParams, SignUpParams } from "./../types/auth";

export const refreshToken = async (params: any): Promise<any> =>
  httpRequest.post<any, any>("/token", params);

export const signIn = async (params: SignInParams): Promise<any> =>
  httpRequest.post("/sign-in", params);

export const signUp = async (params: SignUpParams): Promise<any> =>
  httpRequest.post("/sign-out", params);
