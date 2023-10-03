declare namespace App {
  export type Callback = {
    onSuccess?: (...args: any) => void;
    onFailure?: (...args: any) => void;
    onFinish?: (...args: any) => void;
  };

  export type RequestCallback = (token: string) => Promise<void>;
}
