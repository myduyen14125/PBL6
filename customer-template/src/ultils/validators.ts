import type { ValidatorOptions } from "../types/validator";

export function isRequired(v: string | any | any[]): boolean {
  if (v instanceof Array) {
    return v != null && v != undefined && v.length > 0;
  }
  return v != "" && v != null && v != undefined;
}

export function isEqualsPattern(v: string, pattern: RegExp): boolean {
  if (v == null || v == undefined || v == "") return true;
  return pattern.test(v);
}

export function validate(
  v: string | any,
  validatorOptions: ValidatorOptions
): string {
  const res: any = "";

  if (validatorOptions.required && !isRequired(v)) {
    return validatorOptions.errorsMessage?.required || "Complete this field.";
  }

  if (
    validatorOptions.pattern &&
    !isEqualsPattern(v, validatorOptions.pattern)
  ) {
    return (
      validatorOptions.errorsMessage?.pattern ||
      "This field has incorrect format."
    );
  }

  return res || null;
}
