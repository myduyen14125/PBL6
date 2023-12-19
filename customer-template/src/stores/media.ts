import { get, noop } from 'lodash';

import { uploadMedia } from '../api/upload';

export const useMedia = () => {
  const requestUploadMedia = async ({
    media,
    callback,
  }: {
    media: any;
    callback: App.Callback;
  }): Promise<void> => {
    const onSuccess = get(callback, 'onSuccess', noop);
    const onFailure = get(callback, 'onFailure', noop);
    const onFinish = get(callback, 'onFinish', noop);

    try {
      const response = await uploadMedia(media);
      onSuccess(response);
    } catch (error) {
      onFailure(error);
    } finally {
      onFinish();
    }
  }
}