import { get, noop } from "lodash";
import { defineStore } from "pinia";
import {
  getMySchedules,
  createSchedule,
  deleteSchedule,
} from "./../api/schedule";
import { CreateScheduleParams } from "../types/mentor";

export const useSchedule = defineStore("schedule", () => {
  const requestGetMySchedules = async ({
    callback,
  }: {
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await getMySchedules();
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

  const requestDeleteSchedule = async ({
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
      const response = await deleteSchedule(id);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  return {
    requestGetMySchedules,
    requestCreateSchedule,
    requestDeleteSchedule,
  };
});
