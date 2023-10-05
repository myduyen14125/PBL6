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
  confirmPassword: string;
  gender: boolean | string | null;
  birthday: string | null;
}
