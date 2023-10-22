import { get, noop } from "lodash";
import { defineStore } from "pinia";
import { getUserInfo, getUserBlogs } from "../api/user";
import { GetPaginationParams } from "../types/mentor";

export const useUser = defineStore("user", () => {
  const requestGetUserInfo = async ({
    id,
    callback,
  }: {
    id: string;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await getUserInfo(id);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  const requestGetUserBlogs = async ({
    id,
    params,
    callback,
  }: {
    id: string;
    params: GetPaginationParams;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await getUserBlogs(id, params);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  return {
    requestGetUserInfo,
    requestGetUserBlogs,
  };
});
