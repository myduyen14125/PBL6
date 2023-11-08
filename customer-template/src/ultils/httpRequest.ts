import { forEach, get } from "lodash";
import router from "../router";
import {
  getAccessToken,
  getRefreshToken,
  getUserInfo,
  revokeUser,
  setAccessToken,
  setRefreshToken,
} from "./cache/cookies";
import { shouldRefreshToken } from "./token";
import type {
  AxiosInstance,
  AxiosRequestConfig,
  AxiosResponse,
  InternalAxiosRequestConfig,
} from "axios";
import axios from "axios";
import { API_URL } from "../constants/envKey";
import { refreshToken } from "../api/auth";
import { RouterNameEnum } from "../constants/routeName";
import { StatusCode } from "../constants/statusCode";

const headers: Readonly<Record<string, string | boolean>> = {
  // Accept: "application/json",
  // "Content-Type": "application/json",
};

const AxiosRequest = (
  config: InternalAxiosRequestConfig
): InternalAxiosRequestConfig => {
  try {
    const token = getAccessToken();

    if (token != null) {
      config.headers.Authorization = `Bearer ${token}`;
    }

    // config.headers.Accept = "application/json";

    return config;
  } catch (error) {
    throw new Error(error as string);
  }
};

const ForceLogoutRequest = (
  config: InternalAxiosRequestConfig
): InternalAxiosRequestConfig => {
  return config;
};

class HttpRequest {
  private instance: AxiosInstance | null = null;
  private isRefreshing = false;
  private refreshSubscribers: App.RequestCallback[] = [];

  private get http(): AxiosInstance {
    if (this.instance) {
      return this.instance;
    }
    return this.init();
  }

  init(): AxiosInstance {
    const http = axios.create({
      baseURL: API_URL,
      headers,
    });

    http.interceptors.request.use(AxiosRequest, (error) =>
      Promise.reject(error)
    );

    http.interceptors.request.use(ForceLogoutRequest, (error) =>
      Promise.reject(error)
    );

    http.interceptors.request.use(this.refreshTokenRequest, (error) =>
      Promise.reject(error)
    );

    http.interceptors.response.use(
      (response) => response.data?.data || response.data,
      (error) => {
        const status = get(error, "response.status");
        const errorData = get(error, "response.data");
        switch (status) {
          case StatusCode.Unauthorized: {
            const userInfo = getUserInfo();
            if (userInfo) {
              revokeUser();
              router.push({ name: RouterNameEnum.SignIn });
            }
            break;
          }
          case StatusCode.ValidationFailed:
          case StatusCode.NotFound:
          case StatusCode.BadRequest: {
            return Promise.reject({ ...errorData, status });
          }
          case StatusCode.Forbidden:
          case StatusCode.InternalServerError:
          case StatusCode.TooManyRequests:
            break;
        }
        return Promise.reject(errorData);
      }
    );

    this.instance = http;
    return http;
  }

  refreshTokenRequest = (
    config: InternalAxiosRequestConfig
  ): InternalAxiosRequestConfig => {
    const isRefreshToken = shouldRefreshToken();
    if (isRefreshToken && !this.isRefreshing) {
      this.handleRefreshToken();
    }
    return config;
  };

  handleRefreshToken(callback?: App.Callback): void {
    const oldRefreshToken = getRefreshToken();
    this.isRefreshing = true;
    refreshToken({ refresh_token: oldRefreshToken })
      .then(({ accessToken: newToken, refreshToken: newRefreshToken }) => {
        const onSuccess = get(callback, "onSuccess");
        if (onSuccess) {
          onSuccess(newToken);
        }
        setAccessToken(newToken);
        setRefreshToken(newRefreshToken);
      })
      .catch(() => {
        revokeUser();
        router.push({ name: RouterNameEnum.SignIn });
      })
      .finally(() => {
        this.isRefreshing = false;
      });
  }

  handleAccessTokenError(
    originalRequest: InternalAxiosRequestConfig
  ): Promise<AxiosInstance> {
    if (!this.isRefreshing) {
      this.handleRefreshToken({
        onSuccess: (newToken) => {
          this.onRefreshed(newToken);
          this.refreshSubscribers = [];
        },
      });
    }
    return new Promise((resolve, reject) => {
      this.subscribeTokenRefresh((token: string) => {
        originalRequest.headers.Authorization = `Bearer ${token}`;
        return axios(originalRequest)
          .then((response) => resolve(response.data?.data || response.data))
          .catch((error) => {
            const errorData = get(error, "response.data");
            reject(errorData);
          });
      });
    });
  }

  subscribeTokenRefresh(cb: App.RequestCallback): void {
    this.refreshSubscribers.push(cb);
  }

  onRefreshed(token: string): void {
    forEach(this.refreshSubscribers, (cb) => {
      cb(token);
    });
  }

  request<T, R = AxiosResponse<T>>(config: AxiosRequestConfig): Promise<R> {
    return this.http.request(config);
  }

  get<T, R = AxiosResponse<T>>(
    url: string,
    config?: AxiosRequestConfig
  ): Promise<R> {
    return this.http.get<T, R>(url, config);
  }

  post<T, R = AxiosResponse<T>>(
    url: string,
    data?: T,
    config?: AxiosRequestConfig
  ): Promise<R> {
    return this.http.post<T, R>(url, data, config);
  }

  patch<T, R = AxiosResponse<T>>(
    url: string,
    data?: T,
    config?: AxiosRequestConfig
  ): Promise<R> {
    return this.http.patch<T, R>(url, data, config);
  }

  put<T, R = AxiosResponse<T>>(
    url: string,
    data?: T,
    config?: AxiosRequestConfig
  ): Promise<R> {
    return this.http.put<T, R>(url, data, config);
  }

  delete<T, R = AxiosResponse<T>>(
    url: string,
    config?: AxiosRequestConfig
  ): Promise<R> {
    return this.http.delete<T, R>(url, config);
  }
}

export default new HttpRequest();
