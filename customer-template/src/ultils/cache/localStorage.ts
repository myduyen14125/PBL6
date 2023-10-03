import CacheKey from "../../constants/cacheKey";

export function setAccessToken(token: string): void {
  localStorage.set(CacheKey.TOKEN, token);
}

export function getAccessToken(): string {
  return localStorage.get(CacheKey.TOKEN);
}

export function setRefreshToken(token: string): void {
  localStorage.set(CacheKey.REFRESH_TOKEN, token);
}

export function getRefreshToken(): string {
  return localStorage.get(CacheKey.REFRESH_TOKEN);
}

export function setUserInfo(user: any): void {
  localStorage.set(CacheKey.USER_INFO, JSON.stringify(user));
}

export function getUserInfo(): any {
  return localStorage.get(JSON.parse(CacheKey.USER_INFO));
}

export function isAuthenticated(): boolean {
  const token = getAccessToken();
  return !!token;
}

export function revokeUser(): void {
  localStorage.clear();
}
