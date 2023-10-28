import moment from "moment";

export function formatDate(value: string, formatStr = "MM/DD/YYYY"): string {
  if (value) {
    return moment(new Date(value)).format(formatStr);
  }
  return "";
}

export function formatRelativeDate(dateString: string) {
  const inputDate = moment(dateString, "YYYY-MM-DD");
  const today = moment().startOf("day");
  const yesterday = moment().subtract(1, "day").startOf("day");

  if (inputDate.isSame(today, "day")) {
    return "Today";
  } else if (inputDate.isSame(yesterday, "day")) {
    return "Yesterday";
  } else {
    return formatDate(dateString);
  }
}

export function formatTimeFullCalendar (time: string) {
  const date = new Date(time);
  const day = date.getDate();
  const month = date.getMonth() + 1;
  const year = date.getFullYear();
  const hour = ("0" + date.getHours()).slice(-2);
  const minute = ("0" + date.getMinutes()).slice(-2);
  return `${day}-${month}-${year} ${hour}:${minute}`;
}
