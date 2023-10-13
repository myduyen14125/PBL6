import { get, noop } from "lodash";
import { defineStore } from "pinia";
import { getAllMentors, getSearchMentor } from "../api/mentors";

export const useMentors = defineStore("mentors", () => {
  const requestGetAllMentors = async ({
    callback,
  }: {
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await getAllMentors();
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  const requestGetSearchMentor = async ({
    name,
    callback,
  }: {
    name: string;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await getSearchMentor(name);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  return {
    requestGetAllMentors,
    requestGetSearchMentor,
  };
});
