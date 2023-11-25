import { get, noop } from "lodash";

import { getAllExpertise } from "./../api/expertise";

export const useExpertise = () => {
  const requestGetAllExpertise = async ({
    callback,
  }: {
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, "onSuccess", noop);
    const onFailure = get(callback, "onFailure", noop);
    const onFinish = get(callback, "onFinish", noop);

    try {
      const response = await getAllExpertise();
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  };

  return {
    requestGetAllExpertise,
  };
};
