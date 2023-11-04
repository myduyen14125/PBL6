import { get, noop } from "lodash";
import { defineStore } from "pinia";
import {
  createExperience,
  deleteExperience,
  updateExperience,
} from "./../api/bio";
import { PostExperienceParams } from "./../types/bio";

export const useBio = defineStore("bio", () => {
  const requestCreateExperience = async ({
    params,
    callback,
  }: {
    params: PostExperienceParams;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await createExperience(params);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  const requestDeleteExperience = async ({
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
      const response = await deleteExperience(id);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  const requestUpdateExperience = async ({
    id,
    params,
    callback,
  }: {
    id: string;
    params: PostExperienceParams;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await updateExperience(id, params);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  return {
    requestCreateExperience,
    requestDeleteExperience,
    requestUpdateExperience,
  };
});
