import { get, noop } from "lodash";
import { defineStore } from "pinia";
import { getAllBlogs } from "./../api/blog";
import { CreateBlogParams } from "../types/blog.js";
import { createBlog } from "../api/blog.js";

export const useBlog = defineStore("blog", () => {
  const requestGetAllBlogs = async ({
    callback,
  }: {
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await getAllBlogs();
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

  return {
    requestGetAllBlogs,
    requestCreateBlog,
  };
});
