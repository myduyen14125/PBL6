<template>
  <GuestLayout>
    <div class="course-detail">
      hehe course detail
    </div>
  </GuestLayout>
</template>

<script>
import { ref, onMounted, watch } from "vue";
import SvgIcon from "../../../components/BUI/SvgIcon/SvgIcon.vue";
import avatar from "../../../assets/image/avatar.png";
import advertisementImg from "../../../assets/image/advertisement.jpg";
import GuestLayout from "../../../layout/GuestLayout/GuestLayout.vue";
import MentorCard from "../../../components/MentorCard/MentorCard.vue";
import { useMentors } from "../../../stores/mentors";
import { useBlog } from "../../../stores/blog";
import SwalPopup from "../../../ultils/swalPopup";
import { formatDate } from "../../../ultils/date";

export default {
  components: {
    SvgIcon,
    GuestLayout,
    MentorCard,
  },
  props: {
    id: {
      type: String,
      required: true,
    },
  },
  setup(props) {
    const blogStore = useBlog();
    const blogDetail = ref();

    onMounted(() => {
      getMentors();
      getBlogDetail();
    });

    watch(
      () => props.id,
      (newId, oldId) => {
        getBlogDetail();
      }
    );

    const getBlogDetail = () => {
      blogStore.requestGetBlogById({
        id: props?.id,
        callback: {
          onSuccess: (res) => {
            blogDetail.value = res;
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
      avatar,
      mentors,
      advertisementImg,
      blogDetail,
      formatDate,
    };
  },
};
</script>

<style scoped lang="css">
</style>
