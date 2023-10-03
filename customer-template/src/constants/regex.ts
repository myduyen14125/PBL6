export const RegexLatitude = /^\(?[+-]?(90(\.0+)?|[1-8]?\d(\.\d+)?)$/;
export const RegexLongitude = /^\s?[+-]?(180(\.0+)?|1[0-7]\d(\.\d+)?|\d{1,2}(\.\d+)?)\)?$/;
export const RegexDollar = /^(0|[1-9][0-9]{0,2})*(\.\d{1,2})?$/;
export const RegexUSZipCode = /(^\d{5}$)/;
export const RegexEmail =
  /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])/;
