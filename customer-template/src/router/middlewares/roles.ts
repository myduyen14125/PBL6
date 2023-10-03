import { RouterNameEnum } from "../../constants/routeName";
import type { RouteContext } from "../../types/auth";

export function guest(context: RouteContext): void {
  const { next, isLoggedIn } = context;
  if (isLoggedIn) {
    return next({ name: RouterNameEnum.Home });
  }

  return next();
}

export function auth(context: RouteContext): void {
  const { next, isLoggedIn } = context;
  if (isLoggedIn) {
    return next();
  }

  return next({ name: RouterNameEnum.Home });
}
