import jwtDecode from "jwt-decode";
import moment from "moment";
import { get } from "lodash";
import { getAccessToken } from "./cache/cookies";

export function shouldRefreshToken(): boolean {
  const token = getAccessToken();
  if (token) {
    const data = jwtDecode(token);
    const iat: any = get(data, "iat");
    const exp: any = get(data, "exp");
    const validRemainTime = moment.unix(exp).diff(moment.unix(iat), "seconds") / 3; // 1/3 expire time
    return moment.unix(exp).isAfter(moment()) && moment.unix(exp).diff(moment(), "seconds") <= validRemainTime;
  }
  return false;
}
