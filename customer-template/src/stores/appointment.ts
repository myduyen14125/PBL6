import { get, noop } from "lodash";
import { defineStore } from "pinia";
import {
  getAllUserAppointment,
  createAppointment,
  confirmAppointment,
  cancelAppointment,
} from "./../api/appointment";
import { CreateAppointmentParams } from "../types/appointment.js";
import { GetPaginationParams } from "../types/mentor";

export const useAppointment = defineStore("appointment", () => {
  const requestGetAllUserAppointment = async ({
    params,
    callback,
  }: {
    params: GetPaginationParams
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await getAllUserAppointment(params);
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
  };

  const requestConfirmAppointment = async ({
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
      const response = await confirmAppointment(id);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  const requestCancelAppointment = async ({
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
      const response = await cancelAppointment(id);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  return {
    requestGetAllUserAppointment,
    requestCreateAppointment,
    requestConfirmAppointment,
    requestCancelAppointment,
  };
});
