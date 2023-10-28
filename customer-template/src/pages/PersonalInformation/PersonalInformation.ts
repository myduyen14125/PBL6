import { defineComponent, onMounted, ref, watch } from "vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import router from "../../router";
import { getUserInfo } from "../../ultils/cache/localStorage";
import SwalPopup from "../../ultils/swalPopup";
import { useUser } from "../../stores/user";
import { User } from "../../types/auth";
import { useAuth } from "../../stores/auth";
import { validate } from "../../ultils/validators";
import { RegexPhoneNumber } from "../../constants/regex";

export default defineComponent({
  name: "UserInformation",
  components: { GuestLayout },
  setup() {
    const userStore = useUser();
    const authStore = useAuth();
    const initialUser: User = {
      email: "",
      name: "",
      address: "",
      phone: "",
      date_of_birth: "",
      gender: null,
      facebook_link: "",
      skype_link: "",
    };
    const userInfo = ref<User>(initialUser);
    const error = ref({
      name: "",
      phone: "",
    });
    const isSubmitting = ref(false);

    onMounted(() => {
      getUserInformation();
    });

    const validateName = (): string => {
      error.value.name = validate(userInfo.value.name, {
        required: true,
        errorsMessage: { required: "Đây là trường bắt buộc" },
      });

      return error.value.name;
    };

    const validatePhone = (): string => {
      let err = "";
      err = validate(userInfo.value.phone, {
        required: true,
        pattern: RegexPhoneNumber,
        errorsMessage: {
          required: "Đây là trường bắt buộc",
          pattern: "Điện thoại phải là số từ 10 kí tự",
        },
      });

      if (!err) {
      }

      error.value.phone = err;

      return err;
    };

    const validateForm = (): boolean => {
      const arrRes = [];
      arrRes.push(validateName());
      arrRes.push(validatePhone());

      return arrRes.findIndex((x) => x && x.length > 0) < 0;
    };

    const getUserInformation = () => {
      userStore.requestGetUserInfo({
        id: getUserInfo()._id,
        callback: {
          onSuccess: (res) => {
            userInfo.value = res;
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
          },
        },
      });
    };

    const submitUpdateForm = (e: any) => {
      e.preventDefault();
      if (!validateForm()) return;

      isSubmitting.value = true;
    };

    const updateInfo = () => {
      isSubmitting.value = true;

      userStore.requestUpdateUser({
        params: userInfo.value,
        callback: {
          onSuccess: (res) => {
            isSubmitting.value = false;
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
            isSubmitting.value = false;
          },
        },
      });
    }
    
    return {
      userInfo,
      error,
      isSubmitting,
      validatePhone,
      validateName,
      submitUpdateForm,
      updateInfo,
    };
  },
});
