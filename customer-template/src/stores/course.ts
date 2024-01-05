import { get, noop } from "lodash";

import {
  getAllCourses,
  getCoursePagination,
  createCourse,
  getCourseById,
  deleteCourse,
  updateCourse,
} from "./../api/course";
import {
  buyCourse
} from "./../api/payment";
import { CreateCourseParams, BuyCourseParams } from "../types/course";
import { GetPaginationParams } from "../types/mentor";

export const useCourse = () => {
  const requestGetAllCourses = async ({
    params,
    callback,
  }: {
    params: GetPaginationParams;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await getAllCourses(params);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  }

  const requestGetCourses = async ({
    params,
    callback,
  }: {
    params: GetPaginationParams;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await getCoursePagination(params);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  const requestCreateCourse = async ({
    params,
    callback,
  }: {
    params: CreateCourseParams;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await createCourse(params);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  const requestGetCourseById = async ({
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
      const response = await getCourseById(id);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  const requestDeleteCourse = async ({
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
      const response = await deleteCourse(id);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  const requestUpdateCourse = async ({
    id,
    params,
    callback,
  }: {
    id: string;
    params: CreateCourseParams;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await updateCourse(id, params);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  const requestBuyCourse = async ({
    params,
    callback,
  }: {
    params: BuyCourseParams;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      await buyCourse(params);
      onSuccess();
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  }

  return {
    requestGetAllCourses,
    requestGetCourses,
    requestCreateCourse,
    requestGetCourseById,
    requestDeleteCourse,
    requestUpdateCourse,
    requestBuyCourse,
  };
};
