import { defineComponent, onMounted, ref, watch } from "vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import { formatDate } from "../../ultils/date";
import Swal from "sweetalert2";
import SwalPopup from "../../ultils/swalPopup";
import { useUser } from "../../stores/user";
import { User } from "../../types/auth";
import { useExpertise } from "../../stores/expertise";
import { validate } from "../../ultils/validators";
import { RegexPhoneNumber } from "../../constants/regex";
import avatar from "../../assets/image/avatar.png";
import { Expertise } from "../../types/expertise";
import { getUserInfo } from "../../ultils/cache/cookies";

export default defineComponent({
  name: "UserInformation",
  components: { GuestLayout },
  setup() {
    const expertiseStore = useExpertise();
    const userStore = useUser();
    const initialUser: User = {
      email: "",
      name: "",
      address: "",
      phone: "",
      date_of_birth: "",
      gender: null,
      facebook_link: "",
      skype_link: "",
      expertise: "",
    };
    const userInfo = ref<User>(initialUser);
    const listExpertise = ref<Expertise[]>([]);
    const error = ref({
      name: "",
      phone: "",
      skype_link: "",
    });
    const isSubmitting = ref(false);
    const isLoading = ref(false);

    onMounted(() => {
      getUserInformation();
      getAllExpertise();
    });

    const validateName = (): string => {
      error.value.name = validate(userInfo.value.name, {
        required: true,
        errorsMessage: { required: "Đây là trường bắt buộc" },
      });

      return error.value.name;
    };

    const validateSkypeLink = (): string => {
      error.value.skype_link = validate(userInfo.value.skype_link, {
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
      arrRes.push(validateSkypeLink());
      arrRes.push(validatePhone());

      return arrRes.findIndex((x) => x && x.length > 0) < 0;
    };

    const getAllExpertise = () => {
      expertiseStore.requestGetAllExpertise({
        callback: {
          onSuccess: (res) => {
            listExpertise.value = res;
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

    const getUserInformation = () => {
      isLoading.value = true;
      userStore.requestMyProfile({
        callback: {
          onSuccess: (res) => {
            userInfo.value = {
              ...res,
              expertise: res?.expertise?._id,
            };
            isLoading.value = false;
          },
          onFailure: () => {
            isLoading.value = false;
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

      updateInfo();
    };

    const updateInfo = () => {
      isSubmitting.value = true;

      userStore.requestUpdateUser({
        params: {
          ...userInfo.value,
          date_of_birth: formatDate(
            userInfo?.value?.date_of_birth?.toString(),
            "YYYY-MM-D"
          ),
        },
        callback: {
          onSuccess: (res) => {
            isSubmitting.value = false;
            getUserInformation();
            showToast();
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
    };

    const showToast = () => {
      const Toast = Swal.mixin({
        toast: true,
        position: "top-end",
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
        didOpen: (toast) => {
          toast.addEventListener("mouseenter", Swal.stopTimer);
          toast.addEventListener("mouseleave", Swal.resumeTimer);
        },
      });

      Toast.fire({
        icon: "success",
        title: "Chỉnh sửa thông tin thành công",
      });
    };

    return {
      userInfo,
      error,
      avatar,
      isSubmitting,
      listExpertise,
      isLoading,
      validatePhone,
      validateName,
      validateSkypeLink,
      submitUpdateForm,
      updateInfo,
      getUserInfo,
    };
  },
});
