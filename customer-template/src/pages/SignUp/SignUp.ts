import { defineComponent, ref } from "vue";
import SvgIcon from "../../components/BUI/SvgIcon/SvgIcon.vue";
import logo from "../../assets/image/logo.png";
import facebookLogo from "../../assets/image/facebook.png";
import gmailLogo from "../../assets/image/gmail.png";
import { validate } from "../../ultils/validators";

interface FormData {
  email: string;
  name: string;
  password: string;
  confirmPassword: string;
  gender: boolean | string | null;
  birthday: string | null;
}

export default defineComponent({
  name: "SignUp",
  component: { SvgIcon },
  setup() {
    const initialForm: FormData = {
      email: "",
      name: "",
      password: "",
      confirmPassword: "",
      gender: null,
      birthday: "",
    };
    const initialError: FormData = {
      email: "",
      name: "",
      password: "",
      confirmPassword: "",
      gender: "",
      birthday: "",
    };
    const form = ref(initialForm);
    const error = ref(initialError);
    const isSubmitting = ref(false);

    const validateRequired = (fieldName: keyof FormData): string => {
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
