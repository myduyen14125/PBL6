import type { NavigationGuardNext } from "vue-router";

export interface RouteContext {
  to: any;
  from: any;
  next: NavigationGuardNext;
  user: any;
  isLoggedIn: boolean;
}

export interface SignInParams {
  email: string;
  password: string;
}

export interface SignUpParams {
  email: string;
  name: string;
  password: string;
  gender: boolean | string | null;
  date_of_birth: string | null;
  role: string;
  [elem: string]: any;
}

export interface Authorization {
  _id?: string;
  first_name: string;
  last_name: string;
  avatar: string;
  email: string;
  date_of_birth: string;
  gender: boolean;
  phone: string;
  role: string;
  expiresIn: string;
  accessToken: string;
  refreshToken: string;
}

export interface User {
  _id?: string;
  first_name: string;
  last_name: string;
  avatar?: string;
  email: string;
  date_of_birth?: string;
  gender?: boolean;
  phone?: string;
  role: string;
  facebook_link?: string;
  skype_link?: string;
  bio_id?: string;
}
