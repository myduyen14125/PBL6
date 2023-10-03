export function ramdomStyleAvatar(): any {
  const color = ["success", "danger", "warning", "primary", "info"];
  return color[Math.floor(Math.random() * 5)];
}

export function uuidv4(): string {
  return "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g, function (c) {
    const r = (Math.random() * 16) | 0,
      v = c == "x" ? r : (r & 0x3) | 0x8;
    return v.toString(16);
  });
}
