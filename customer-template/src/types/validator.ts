export interface ValidatorOptions {
  required?: boolean;
  pattern?: RegExp;
  errorsMessage?: ValidateErrorMessage;
}

export interface ValidateErrorMessage {
  required?: string;
  pattern?: string;
}
