import { defineComponent, ref } from "vue";
import { useRouter } from "vue-router";
import { RouterNameEnum } from "../../constants/routeName";
import SvgIcon from "../../components/BUI/SvgIcon/SvgIcon.vue";
import logo from "../../assets/svg/logo-color.svg";
import facebookLogo from "../../assets/image/facebook.png";
import gmailLogo from "../../assets/image/gmail.png";
import { validate } from "../../ultils/validators";
import { SignInParams } from "../../types/auth";
import { useAuth } from "../../stores/auth";
import SwalPopup from "../../ultils/swalPopup";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";

export default defineComponent({
  name: "SignIn",
  components: { GuestLayout, SvgIcon },
  setup() {
    const router = useRouter();
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
    const isShowPassword = ref(false);

    const validateRequired = (fieldName: keyof SignInParams): string => {
      const err = validate(form.value[fieldName], {
        required: true,
        errorsMessage: { required: "Đây là trường bắt buộc" },
      });

      error.value[fieldName] = err;

      return err;
    };

    const validateEmail = (): string => {
      let err = "";
      if (form.value.email === "") {
        err = "Đây là trường bắt buộc";
      } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.value.email)) {
        err = "Email không hợp lệ";
      }

      error.value.email = err;

      return err;
    };

    const validatePassword = (): string => {
      let err = "";

      if (form.value.password === "") {
        err = "Đây là trường bắt buộc";
      } else if (form.value.password.length < 6) {
        err = "Mật khẩu phải có ít nhất 6 ký tự";
      } else if (form.value.password.length > 20) {
        err = "Mật khẩu phải có tối đa 20 ký tự";
      } else if (!/[A-Z]/.test(form.value.password)) {
        err = "Mật khẩu phải chứa ít nhất 1 chữ cái in hoa";
      } else if (!/[!@#$%^&*(),.?":{}|<>]/.test(form.value.password)) {
        err = "Mật khẩu phải chứa ít nhất 1 kí tự đặc biệt";
      }

      error.value.password = err;

      return err;
    };

    const validateForm = (): boolean => {
      const arrRes = [];
      arrRes.push(validateRequired("email"));
      arrRes.push(validateRequired("password"));
      arrRes.push(validateEmail());
      arrRes.push(validatePassword());
      return arrRes.findIndex((x) => x && x.length > 0) < 0;
    };

    const submitForm = (e: any) => {
      e.preventDefault();
      if (!validateForm()) return;

      isSubmitting.value = true;
      authStore.requestSignIn({
        params: form.value,
        callback: {
          onSuccess: (res) => {
            isSubmitting.value = false;
            SwalPopup.swalResultPopup("Đăng nhập thành công!", "success");
            // todo: hide swalpopup after 2s
            router.push({ name: RouterNameEnum.Home });
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Xin lỗi, thông tin đăng nhập không chính xác, cần kiểm tra lại email hoặc mật khẩu!",
              "error"
            );
            isSubmitting.value = false;
          },
        },
      });
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
      validateEmail,
      validatePassword,
      isShowPassword,
    };
  },
});
