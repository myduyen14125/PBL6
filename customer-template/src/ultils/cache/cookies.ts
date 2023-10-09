import CacheKey from "../../constants/cacheKey";
import UniversalCookie from "universal-cookie";

const cookie = new UniversalCookie();

export function setAccessToken(token: string): void {
  cookie.set(CacheKey.TOKEN, token, { path: "/" });
}

export function getAccessToken(): string {
  return cookie.get(CacheKey.TOKEN);
}

export function setRefreshToken(token: string): void {
  cookie.set(CacheKey.REFRESH_TOKEN, token, {
    path: "/",
  });
}

export function getRefreshToken(): string {
  return cookie.get(CacheKey.REFRESH_TOKEN);
}

export function setUserInfo(user: any): void {
  cookie.set(CacheKey.USER_INFO, user, { path: "/" });
}

export function getUserInfo(): any {
  return cookie.get(CacheKey.USER_INFO);
}

export function isAuthenticated(): boolean {
  const token = getAccessToken();
  return !!token;
}

export function revokeUser(): void {
  const options = {
    path: "/",
  };
  cookie.remove(CacheKey.TOKEN, options);
  cookie.remove(CacheKey.REFRESH_TOKEN, options);
  cookie.remove(CacheKey.USER_INFO, options);
}
