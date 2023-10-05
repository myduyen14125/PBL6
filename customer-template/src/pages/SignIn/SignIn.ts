import { defineComponent, ref } from "vue";
import SvgIcon from "../../components/BUI/SvgIcon/SvgIcon.vue";
import logo from "../../assets/image/logo.png";
import facebookLogo from "../../assets/image/facebook.png";
import gmailLogo from "../../assets/image/gmail.png";
import { validate } from "../../ultils/validators";

interface FormData {
  email: string;
  password: string;
}

export default defineComponent({
  name: "SignIn",
  component: { SvgIcon },
  setup() {
    const initialForm: FormData = {
      email: "",
      password: "",
    };
    const initialError: FormData = {
      email: "",
      password: "",
    };
    const form = ref(initialForm);
    const error = ref(initialError);

    const validateRequired = (fieldName: keyof FormData): string => {
      const err = validate(form.value[fieldName], {
        required: true,
        errorsMessage: { required: "This field is required." },
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
    };

    return {
      logo,
      facebookLogo,
      gmailLogo,
      form,
      error,
      submitForm,
      validateRequired,
    };
  },
});
