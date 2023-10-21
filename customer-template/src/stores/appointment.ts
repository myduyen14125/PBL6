import { get, noop } from "lodash";
import { defineStore } from "pinia";
import { getAllUserAppointment, createAppointment } from "./../api/appointment";
import { CreateAppointmentParams } from "../types/appointment.js";

export const useAppointment = defineStore("appointment", () => {
  const requestGetAllUserAppointment = async ({
    params,
    callback,
  }: {
    params: CreateAppointmentParams;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await createAppointment(params);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  const requestCreateAppointment = async ({
    params,
    callback,
  }: {
    params: CreateAppointmentParams;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await createAppointment(params);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  }

  return {
    requestGetAllUserAppointment,
    requestCreateAppointment,
  };
});
