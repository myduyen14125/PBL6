import { get, noop } from "lodash";
import { defineStore } from "pinia";
import { getBlogPagination, createBlog, getBlogById } from "./../api/blog";
import { CreateBlogParams } from "../types/blog";
import { GetPaginationParams } from "../types/mentor";

export const useBlog = defineStore("blog", () => {
  const requestGetBlogs = async ({
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
      const response = await getBlogPagination(params);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  const requestCreateBlog = async ({
    params,
    callback,
  }: {
    params: CreateBlogParams;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await createBlog(params);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  const requestGetBlogById = async ({
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
      const response = await getBlogById(id);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  return {
    requestGetBlogs,
    requestCreateBlog,
    requestGetBlogById,
  };
});
