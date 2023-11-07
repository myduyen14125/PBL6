import { defineComponent, ref } from "vue";
import SvgIcon from "../../components/BUI/SvgIcon/SvgIcon.vue";
import logo from "../../assets/svg/logo-color.svg";
import { ForgetPasswordParams } from "../../types/auth";
import { useAuth } from "../../stores/auth";
import SwalPopup from "../../ultils/swalPopup";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";

export default defineComponent({
  name: "ForgetPassword",
  components: { GuestLayout, SvgIcon },
  setup() {
    const authStore = useAuth();
    const form = ref<ForgetPasswordParams>({
      email: "",
    });
    const error = ref<ForgetPasswordParams>({
      email: "",
    });
    const isSubmitting = ref(false);
    const resetData = () => {
      form.value = {
        email: "",
      };

      error.value = {
        email: "",
      };
    };
    const getPassword = () => {
      isSubmitting.value = true;
      authStore.requestGetPassword({
        params: form.value,
        callback: {
          onSuccess: (res) => {
            isSubmitting.value = false;
            resetData();

            SwalPopup.swalResultPopup(
              "Check your email for new password.",
              "success"
            );
          },
          onFailure: (res) => {
            resetData();
            SwalPopup.swalResultPopup("Error.", "error");
            isSubmitting.value = false;
          },
        },
      });
    };

    return {
      logo,
      form,
      error,
      isSubmitting,
      getPassword,
    };
  },
});
