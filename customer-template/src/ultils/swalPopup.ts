import Swal from "sweetalert2";
import { Vue } from "vue-facing-decorator";

export default class SwalPopup extends Vue {
  public static swalResultPopup(title: string, type: string | any): void {
    Swal.fire({
      text: `${title}`,
      icon: type,
      buttonsStyling: false,
      focusConfirm: false,
      confirmButtonText: "Ok, got it!",
      customClass: {
        confirmButton: "btn btn-primary",
      },
    });
  }

  public static swalDeletePopup(
    title: string,
    callback: { onConfirmed?: () => void; onCanceled?: () => void },
    options: { confirmButtonText?: string; cancelButtonText?: string } | null = null,
  ): void {
    Swal.fire({
      text: `${title}`,
      icon: "warning",
      buttonsStyling: false,
      showCancelButton: true,
      focusCancel: true,
      confirmButtonText: options?.confirmButtonText || "Yes, delete!",
      cancelButtonText: options?.cancelButtonText || "No, cancel",
      customClass: {
        confirmButton: "btn btn-danger",
        cancelButton: "btn btn-light btn-active-light-primary",
      },
    }).then((result: any) => {
      if (result.isConfirmed) {
        if (callback.onConfirmed) callback.onConfirmed();
      } else if (result.dismiss === Swal.DismissReason.cancel) {
        if (callback.onCanceled) callback.onCanceled();
      }
    });
  }

  public static swalPopup(
    title: string,
    options: {
      confirmButtonText?: string;
      cancelButtonText?: string;
      callback: { onConfirmed?: () => void; onCanceled?: () => void };
    } | null = null,
  ): void {
    Swal.fire({
      text: `${title}`,
      icon: "warning",
      buttonsStyling: false,
      showCancelButton: true,
      focusCancel: true,
      confirmButtonText: options?.confirmButtonText || "Yes, delete!",
      cancelButtonText: options?.cancelButtonText || "No, cancel",
      customClass: {
        confirmButton: "btn btn-danger",
        cancelButton: "btn btn-light btn-active-light-primary",
      },
    }).then((result: any) => {
      if (result.isConfirmed) {
        if (options?.callback.onConfirmed) options?.callback.onConfirmed();
      } else if (result.dismiss === Swal.DismissReason.cancel) {
        if (options?.callback.onCanceled) options?.callback.onCanceled();
      }
    });
  }
}
