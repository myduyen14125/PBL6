import { defineComponent, onMounted, ref, watch, type Ref } from "vue";
import personLogo from "../../assets/image/ic-mentee.png";
import heartLogo from "../../assets/image/followed.png";
import ratingLogo from "../../assets/image/rating.png";
import hourLogo from "../../assets/image/hour.png";
import coverImg from "../../assets/image/cover.jpg";
import avatarImg from "../../assets/image/cover.jpg";
import advertisementImg from "../../assets/image/advertisement.jpg";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import MentorPost from "../../components/MentorPost/MentorPost.vue";
import ExperienceCard from "./element/ExperienceCard.vue";
import { useUser } from "../../stores/user";
import { useMentors } from "../../stores/mentors";
import { useAuth } from "../../stores/auth";
import SwalPopup from "../../ultils/swalPopup";
import { getUserInfo } from "../../ultils/cache/localStorage";
import router from "../../router";
import { GetPaginationParams } from "../../types/mentor";

export default defineComponent({
  name: "UserInformation",
  components: { GuestLayout, MentorPost, ExperienceCard },
  props: {
    id: {
      type: String,
      required: true,
    },
  },
  setup(props: any) {
    const userStore = useUser();
    const mentorsStore = useMentors();
    const authStore = useAuth();
    const selectedOption = ref("profile");
    const userInfo = ref();
    const userBlogs = ref([]);
    const mentors = ref([]);
    const showEdit = getUserInfo()?._id == props.id;
    const avatarSrc = ref('');

    onMounted(() => {
      getUserInformation(props.id);
      getMentors();
      getUserBlogs(props.id);
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

    const getUserBlogs = (id: string) => {
      userStore.requestGetUserBlogs({
        id: props.id,
        params: { page: 1, limit: 5 } as GetPaginationParams,
        callback: {
          onSuccess: (res) => {
            userBlogs.value = res.blogs;
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

    watch(
      () => props.id,
      (newId, oldId) => {
        getUserInformation(newId);
      }
    );

    const getMentors = () => {
      mentorsStore.requestGetMentors({
        params: { page: 1, limit: 5 } as GetPaginationParams,
        callback: {
          onSuccess: (res) => {
            mentors.value = res.mentors.filter(
              (item: any) => item._id != props?.id
            );
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

    const uploadAvatar = (e: any) => {
      const avatar = e.target.files[0];
      if (!avatar) return;

      userStore.requestUploadAvatar({
        avatar: avatar,
        callback: {
          onSuccess: (res) => {
            // SwalPopup.swalResultPopup(
            //   "Your avatar has been updated successfully.",
            //   "success"
            // );
            console.log(res)
            // avatarSrc.value = res.avatar;
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
      personLogo,
      heartLogo,
      coverImg,
      avatarImg,
      avatarSrc,
      ratingLogo,
      hourLogo,
      advertisementImg,
      selectedOption,
      userInfo,
      userBlogs,
      showEdit,
      mentors,
      router,
      getUserInfo,
      uploadAvatar,
    };
  },
});
