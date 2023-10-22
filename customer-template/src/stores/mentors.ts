import { get, noop } from "lodash";
import { defineStore } from "pinia";
import {
  getMentorsPagination,
  getSearchMentor,
  createSchedule,
} from "../api/mentors";
import {
  CreateScheduleParams,
  GetMentorsParams,
  SearchMentorsParams,
} from "../types/mentor";

export const useMentors = defineStore("mentors", () => {
  const requestGetMentors = async ({
    params,
    callback,
  }: {
    params: GetMentorsParams;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await getMentorsPagination(params);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  const requestGetSearchMentor = async ({
    params,
    callback,
  }: {
    params: SearchMentorsParams;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await getSearchMentor(params);
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
    requestGetMentors,
    requestGetSearchMentor,
    requestCreateSchedule,
  };
});
