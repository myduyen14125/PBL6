import { get, noop } from "lodash";

import {
  getUserInfo,
  getUserBlogs,
  getUserSchedules,
  updateUser,
  uploadAvatar,
  getMyProfile,
  changePassword,
} from "../api/user";
import { GetPaginationParams } from "../types/mentor";
import { User, ChangePasswordParams } from "../types/auth";

export const useUser = () => {
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

  const requestGetUserSchedules = async ({
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
      const response = await getUserSchedules(id);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  const requestUpdateUser = async ({
    params,
    callback,
  }: {
    params: User;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await updateUser(params);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  const requestUploadAvatar = async ({
    avatar,
    callback,
  }: {
    avatar: any;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await uploadAvatar(avatar);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  const requestMyProfile = async ({
    callback,
  }: {
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await getMyProfile();
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  const requestChangePassword = async ({
    params,
    callback,
  }: {
    params: ChangePasswordParams;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await changePassword(params);
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
    requestGetUserSchedules,
    requestUpdateUser,
    requestUploadAvatar,
    requestMyProfile,
    requestChangePassword,
  };
};
