export function formatCurrency(value: string | undefined | number): string {
  if (value) {
    return "$" + Number(value).toFixed(2);
  }
  return "$0.00";
}
