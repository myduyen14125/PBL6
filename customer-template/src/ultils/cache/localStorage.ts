import CacheKey from "../../constants/cacheKey";

export function setAccessToken(token: string): void {
  localStorage.setItem(CacheKey.TOKEN, token);
}

export function getAccessToken() {
  return localStorage.getItem(CacheKey.TOKEN);
}

export function setRefreshToken(token: string): void {
  localStorage.setItem(CacheKey.REFRESH_TOKEN, token);
}

export function getRefreshToken() {
  return localStorage.getItem(CacheKey.REFRESH_TOKEN);
}

export function setUserInfo(user: any): void {
  localStorage.setItem(CacheKey.USER_INFO, JSON.stringify(user));
}

export function getUserInfo(): any {
  const userInfo = localStorage.getItem(CacheKey.USER_INFO);
  return userInfo ? JSON.parse(userInfo) : null;
}

export function isAuthenticated(): boolean {
  const token = getAccessToken();
  return !!token;
}

export function revokeUser(): void {
  localStorage.clear();
}
