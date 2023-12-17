import { defineComponent, ref } from "vue";
import { RouterNameEnum } from "../../constants/routeName";
import SvgIcon from "../../components/BUI/SvgIcon/SvgIcon.vue";
import logo from "../../assets/svg/logo-color.svg";
import facebookLogo from "../../assets/image/facebook.png";
import gmailLogo from "../../assets/image/gmail.png";
import { validate } from "../../ultils/validators";
import { SignUpParams } from "../../types/auth";
import { useAuth } from "../../stores/auth";
import SwalPopup from "../../ultils/swalPopup";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import { useRouter } from "vue-router";

export default defineComponent({
  name: "SignUp",
  components: { GuestLayout, SvgIcon },
  setup() {
    const router = useRouter();
    const authStore = useAuth();
    const initialForm: SignUpParams = {
      email: "",
      name: "",
      password: "",
      // confirmPassword: "",
      gender: null,
      date_of_birth: "",
      role: "",
    };

    const initialError: SignUpParams = {
      email: "",
      name: "",
      password: "",
      // confirmPassword: "",
      gender: "",
      date_of_birth: "",
      role: "",
    };
    const form = ref<SignUpParams>(initialForm);
    const error = ref(initialError);
    const isSubmitting = ref(false);
    const isShowPassword = ref(false);

    const validateRequired = (fieldName: keyof SignUpParams): string => {
      const err = validate(form.value[fieldName], {
        required: true,
        errorsMessage: { required: "Đây là trường bắt buộc" },
      });
      error.value[fieldName] = err;
      return err;
    };

    const validateDateOfBirth = (): string => {
      let err = "";
      if (!form.value.date_of_birth) {
        err = "Đây là trường bắt buộc";
      } else if (form.value.date_of_birth.length !== 10) {
        err = "Ngày sinh không hợp lệ";
      } else if (
        new Date(form.value.date_of_birth).getTime() > new Date().getTime()
      ) {
        err = "Ngày sinh không được lớn hơn ngày hiện tại";
      }
      error.value.date_of_birth = err;
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
      arrRes.push(validateRequired("gender"));
      arrRes.push(validateRequired("date_of_birth"));
      arrRes.push(validateRequired("role"));
      arrRes.push(validateEmail());
      arrRes.push(validatePassword());
      arrRes.push(validateDateOfBirth());
      arrRes.push(validateConfirmPassword);

      return arrRes.findIndex((x) => x && x.length > 0) < 0;
    };

    const submitForm = (e: any) => {
      e.preventDefault();
      if (!validateForm()) return;

      isSubmitting.value = true;

      authStore.requestSignUp({
        params: form.value,
        callback: {
          onSuccess: (res) => {
            SwalPopup.swalResultPopup(
              "Đăng ký tài khoản thành công! Chào mừng bạn đến với IT Mentor! Vui lòng cập nhật thông tin của bạn.",
              "sucess",
              {
                onConfirmed: () => {
                  router.push({ path: "/personal-info" });
                },
              }
            );
            router.push({ name: RouterNameEnum.Home });
            isSubmitting.value = false;
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Người dùng đã tồn tại, vui lòng đăng ký với tài khoản khác!",
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
      validateDateOfBirth,
      validateConfirmPassword,
      isShowPassword,
    };
  },
});
