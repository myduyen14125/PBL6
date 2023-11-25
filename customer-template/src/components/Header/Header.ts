import { defineComponent, onMounted, ref, watch } from "vue";
import { useAuth } from "./../../stores/auth";
import SvgIcon from "../BUI/SvgIcon/SvgIcon.vue";
import logo from "../../assets/image/logo.png";
import avatar from "../../assets/image/avatar.png";
import MessageCard from "../MessageCard/MessageCard.vue";
import { getUserInfo } from "../../ultils/cache/cookies";
import { useUser } from "../../stores/user";
import SwalPopup from "../../ultils/swalPopup";
import router from "../../router";

export default defineComponent({
  name: "Header",
  components: { MessageCard, SvgIcon },
  setup() {
    const authStore = useAuth();
    const isLogin = ref(authStore.userInfo.value ? true : false);
    const userStore = useUser();
    const userInfo = ref();

    watch(
      () => authStore.userInfo.value,
      function () {
        isLogin.value = authStore.userInfo.value ? true : false;
      }
    );

    const navLinks = [
      {
        path: "/",
        name: "TRANG CHỦ",
      },
      {
        path: "/mentors",
        name: "TÌM KIẾM MENTOR",
      },
    ];

    onMounted(() => {
      toggleMenu();
      if (isLogin.value) {
        getMyProfile();
      }
    });

    const toggleMenu = (): void => {
      const burger = document.querySelectorAll(".navbar-burger");
      const menu = document.querySelectorAll(".navbar-menu");

      if (burger.length && menu.length) {
        for (var i = 0; i < burger.length; i++) {
          burger[i].addEventListener("click", function () {
            for (var j = 0; j < menu.length; j++) {
              menu[j].classList.toggle("d-none");
            }
          });
        }
      }

      // close
      const close = document.querySelectorAll(".navbar-close");
      const backdrop = document.querySelectorAll(".navbar-backdrop");

      if (close.length) {
        for (var i = 0; i < close.length; i++) {
          close[i].addEventListener("click", function () {
            for (var j = 0; j < menu.length; j++) {
              menu[j].classList.toggle("d-none");
            }
          });
        }
      }

      if (backdrop.length) {
        for (var i = 0; i < backdrop.length; i++) {
          backdrop[i].addEventListener("click", function () {
            for (var j = 0; j < menu.length; j++) {
              menu[j].classList.toggle("hidden");
            }
          });
        }
      }
    };

    const getMyProfile = () => {
      userStore.requestMyProfile({
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

    return {
      router,
      logo,
      avatar,
      navLinks,
      isLogin,
      authStore,
      userInfo,
      getUserInfo,
    };
  },
});
