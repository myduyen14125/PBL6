import { get, noop } from "lodash";
import { SignInParams, SignUpParams } from "../types/auth.js";
import { signIn, signUp } from "../api/auth.js";
import { defineStore } from "pinia";

export const useAuth = defineStore("auth", () => {
  const requestSignIn = async ({
    params,
    callback,
  }: {
    params: SignInParams;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await signIn(params);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  const requestSignUp = async ({
    params,
    callback,
  }: {
    params: SignUpParams;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await signUp(params);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  return { requestSignIn, requestSignUp };
});
