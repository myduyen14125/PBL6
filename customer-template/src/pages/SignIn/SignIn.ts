import { defineComponent, ref } from "vue";
import router from "../../router";
import { RouterNameEnum } from "../../constants/routeName";
import SvgIcon from "../../components/BUI/SvgIcon/SvgIcon.vue";
import logo from "../../assets/image/logo.png";
import facebookLogo from "../../assets/image/facebook.png";
import gmailLogo from "../../assets/image/gmail.png";
import { validate } from "../../ultils/validators";
import { SignInParams } from "../../types/auth";
import { useAuth } from "../../stores/auth";
import SwalPopup from "../../ultils/swalPopup";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import { setAccessToken } from "../../ultils/cache/cookies";

export default defineComponent({
  name: "SignIn",
  components: { GuestLayout, SvgIcon },
  setup() {
    const authStore = useAuth();
    const initialForm: SignInParams = {
      email: "",
      password: "",
    };
    const initialError: SignInParams = {
      email: "",
      password: "",
    };
    const form = ref<SignInParams>(initialForm);
    const error = ref(initialError);
    const isSubmitting = ref(false);

    const validateRequired = (fieldName: keyof SignInParams): string => {
      const err = validate(form.value[fieldName], {
        required: true,
        errorsMessage: { required: "Đây là trường bắt buộc" },
      });

      error.value[fieldName] = err;

      return err;
    };

    const validateForm = (): boolean => {
      const arrRes = [];
      arrRes.push(validateRequired("email"));
      arrRes.push(validateRequired("password"));

      return arrRes.findIndex((x) => x && x.length > 0) < 0;
    };

    const submitForm = (e: any) => {
      e.preventDefault();
      if (!validateForm()) return;

      isSubmitting.value = true;
      setAccessToken("ok");
      // authStore.requestSignIn({
      //   params: form.value,
      //   callback: {
      //     onSuccess: (res) => {},
      //     onFailure: () => {
      //       SwalPopup.swalResultPopup(
      //         "Sorry, looks like there are some errors detected, please try again.",
      //         "error"
      //       );
      //     },
      //   },
      // });
      router.push({ name: RouterNameEnum.Home });
    };

    return {
      logo,
      facebookLogo,
      gmailLogo,
      form,
      error,
      isSubmitting,
      submitForm,
      validateRequired,
    };
  },
});
