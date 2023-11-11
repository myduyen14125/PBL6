import moment from "moment";

export function formatDate(
  value: string | undefined | null | Date,
  formatStr = "MM/DD/YYYY"
): string {
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

export function formatTimeFullCalendar(time: string) {
  let timeZone = +7;
  let date = new Date(time);
  date.setHours(date.getHours() - timeZone);
  let day = date.getDate();
  let month = date.getMonth() + 1;
  let year = date.getFullYear();
  let hour = date.getHours();
  let minute = date.getMinutes();
  return `${day}-${month}-${year} ${hour}:${minute}`;
}

export function isDateBeforeToday(time: Date) {
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  time.setHours(0, 0, 0, 0);
  return time.getTime() >= today.getTime();
}
