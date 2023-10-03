import type { NavigationGuardNext } from "vue-router";

export interface RouteContext {
  to: any;
  from: any;
  next: NavigationGuardNext;
  user: any;
  isLoggedIn: boolean;
}
