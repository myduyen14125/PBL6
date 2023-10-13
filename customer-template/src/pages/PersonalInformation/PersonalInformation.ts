import { defineComponent, onMounted, ref, watch } from "vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import router from "../../router";
import { getUserInfo } from "../../ultils/cache/localStorage";
import SwalPopup from "../../ultils/swalPopup";
import { useUser } from "../../stores/user";
import { User } from "../../types/auth";
import { useAuth } from "../../stores/auth";

export default defineComponent({
  name: "UserInformation",
  components: { GuestLayout },
  props: {
    id: {
      type: String,
      required: true,
    },
  },
  setup(props) {
    const userStore = useUser();
    const authStore = useAuth();
    const initialUser: User = {};
    const userInfo = ref<User>(initialUser);
    const isSubmitting = ref(false);

    onMounted(() => {
      getUserInformation(props.id);
    });

    const getUserInformation = (id: string) => {
      userStore.requestGetUserInfo({
        id: props.id,
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
      isSubmitting.value = true;
        
      };

    return {
      userInfo,
      submitUpdateForm,
    };
  },
});
