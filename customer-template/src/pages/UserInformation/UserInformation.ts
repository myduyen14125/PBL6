import { defineComponent, onMounted, ref, watch, type Ref } from "vue";
import personLogo from "../../assets/image/ic-mentee.png";
import heartLogo from "../../assets/image/followed.png";
import ratingLogo from "../../assets/image/rating.png";
import hourLogo from "../../assets/image/hour.png";
import coverImg from "../../assets/image/cover.jpg";
import avatarImg from "../../assets/image/avatar.png";
import advertisementImg from "../../assets/image/advertisement.jpg";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import MentorPost from "../../components/MentorPost/MentorPost.vue";
import ExperienceCard from "./element/ExperienceCard/ExperienceCard.vue";
import { useUser } from "../../stores/user";
import { useMentors } from "../../stores/mentors";
import { useAuth } from "../../stores/auth";
import SwalPopup from "../../ultils/swalPopup";
import { getUserInfo } from "../../ultils/cache/localStorage";
import router from "../../router";
import { GetPaginationParams } from "../../types/mentor";
import SvgIcon from "../../components/BUI/SvgIcon/SvgIcon.vue";
import AvatarModal from "./element/AvatarModal/AvatarModal.vue";
import ExperienceModal from "./element/ExperienceModal/ExperienceModal.vue";
import EducationModal from "./element/EducationModal/EducationModal.vue";

export default defineComponent({
  name: "UserInformation",
  components: {
    GuestLayout,
    MentorPost,
    ExperienceCard,
    SvgIcon,
    AvatarModal,
    ExperienceModal,
    EducationModal,
  },
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
    const avatarSrc = ref("");
    const fileImage = ref<any>(null);
    const avatarModal: Ref<any> = ref<typeof AvatarModal | null>(null);
    const fileRef: Ref<HTMLDivElement | null> = ref(null);
    const experienceModal: Ref<any> = ref<typeof ExperienceModal | null>(null);
    const educationModal: Ref<any> = ref<typeof EducationModal | null>(null);

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

    const uploadAvatar = () => {
      userInfo.value = {
        ...userInfo.value,
        avatar: URL.createObjectURL(fileImage.value),
      };

      userStore.requestUploadAvatar({
        avatar: fileImage.value,
        callback: {
          onSuccess: (res) => {},
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
          },
        },
      });
    };

    const toggleAvatar = (e: any): void => {
      const avatar = e.target.files[0];
      if (!avatar) return;
      fileImage.value = avatar;
      avatarModal?.value?.show();
    };

    const toggleExperience = (): void => {
      experienceModal?.value?.show();
    };

    const toggleEducation = (): void => {
      educationModal?.value?.show();
    };

    const getAvatar = () => {
      if (fileImage.value) {
        return URL.createObjectURL(fileImage.value);
      }
      return "";
    };

    const clickInputFile = () => {
      if (showEdit) {
        if (fileRef.value) {
          fileRef.value.click();
        }
      }
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
      fileRef,
      fileImage,
      avatarModal,
      experienceModal,
      educationModal,
      getUserInfo,
      uploadAvatar,
      toggleAvatar,
      toggleExperience,
      toggleEducation,
      getAvatar,
      clickInputFile,
      getUserInformation,
    };
  },
});
