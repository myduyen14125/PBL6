import { get, noop } from "lodash";
import { defineStore } from "pinia";
import { getAllMentors, getSearchMentor, createSchedule } from "../api/mentors";
import { CreateScheduleParams } from "../types/mentor";

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

  const requestCreateSchedule = async ({
    params,
    callback,
  }: {
    params: CreateScheduleParams[];
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await createSchedule(params);
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
    requestCreateSchedule,
  };
});
