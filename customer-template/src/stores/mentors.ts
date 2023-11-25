import { get, noop } from "lodash";

import { getMentorsPagination, getSearchMentor } from "../api/mentors";
import { GetPaginationParams, SearchMentorsParams } from "../types/mentor";

export const useMentors = () => {
  const requestGetMentors = async ({
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

  return {
    requestGetMentors,
    requestGetSearchMentor,
  };
};
