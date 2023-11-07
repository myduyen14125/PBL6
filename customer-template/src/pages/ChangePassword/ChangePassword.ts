import { defineComponent, ref } from "vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import SwalPopup from "../../ultils/swalPopup";
import { ChangePasswordParams } from "../../types/auth";
import { useUser } from "../../stores/user";

export default defineComponent({
  name: "ChangePassword",
  components: { GuestLayout },
  setup() {
    const isSubmitting = ref(false);
    const userStore = useUser();
    const form = ref<ChangePasswordParams>({
      old_password: "",
      new_password: "",
      re_password: "",
    });
    const error = ref<ChangePasswordParams>({
      old_password: "",
      new_password: "",
      re_password: "",
    });

    const resetData = () => {
      form.value = {
        old_password: "",
        new_password: "",
        re_password: "",
      };

      error.value = {
        old_password: "",
        new_password: "",
        re_password: "",
      };
    };
    const changePassword = () => {
      if (form.value.new_password != form.value.re_password) {
        SwalPopup.swalResultPopup(
          "New password and confirm password do not match.",
          "error"
        );
        return;
      }
      isSubmitting.value = true;

      userStore.requestChangePassword({
        params: form.value,
        callback: {
          onSuccess: (res) => {
            isSubmitting.value = false;
            resetData();
            SwalPopup.swalResultPopup(
              "Password has been successfully changed.",
              "success"
            );
          },
          onFailure: (res) => {
            resetData();
            SwalPopup.swalResultPopup(res.message, "error");
            isSubmitting.value = false;
          },
        },
      });
    };

    return { isSubmitting, changePassword, form, error };
  },
});
