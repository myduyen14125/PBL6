import { defineComponent, ref } from "vue";
import SvgIcon from "../../components/BUI/SvgIcon/SvgIcon.vue";
import logo from "../../assets/image/logo.png";
import facebookLogo from "../../assets/image/facebook.png";
import gmailLogo from "../../assets/image/gmail.png";
import { validate } from "../../ultils/validators";
import { SignUpParams } from "../../types/auth";
import { useAuth } from "../../stores/auth";
import SwalPopup from "../../ultils/swalPopup";

export default defineComponent({
  name: "SignUp",
  component: { SvgIcon },
  setup() {
    const authStore = useAuth();
    const initialForm: SignUpParams = {
      email: "",
      name: "",
      password: "",
      confirmPassword: "",
      gender: null,
      birthday: "",
    };
    const initialError: SignUpParams = {
      email: "",
      name: "",
      password: "",
      confirmPassword: "",
      gender: "",
      birthday: "",
    };
    const form = ref<SignUpParams>(initialForm);
    const error = ref(initialError);
    const isSubmitting = ref(false);

    const validateRequired = (fieldName: keyof SignUpParams): string => {
      const err = validate(form.value[fieldName], {
        required: true,
        errorsMessage: { required: "Đây là trường bắt buộc" },
      });

      error.value[fieldName] = err;

      return err;
    };

    const validateConfirmPassword = (): string => {
      let err = "";
      if (form.value.confirmPassword == "") {
        err = "Đây là trường bắt buộc";
      } else if (form.value.password !== form.value.confirmPassword) {
        err = "Nhập lại mật khẩu không đúng";
      }

      error.value.confirmPassword = err;

      return err;
    };

    const validateForm = (): boolean => {
      const arrRes = [];
      arrRes.push(validateRequired("email"));
      arrRes.push(validateRequired("name"));
      arrRes.push(validateRequired("password"));
      arrRes.push(validateConfirmPassword);

      return arrRes.findIndex((x) => x && x.length > 0) < 0;
    };

    const submitForm = (e: any) => {
      e.preventDefault();
      if (!validateForm()) return;

      isSubmitting.value = true;

      // authStore.requestSignUp({
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

      window.alert("đăng kí thành công");
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
      validateConfirmPassword,
    };
  },
});
