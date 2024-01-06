<template>
  <div class="card p-2 border-0 relative shadow-md hover:shadow-lg">
    <div
      v-if="getUserInfo()?.role == 'mentor'"
      class="position-absolute top-8 right-4 translate-middle-y d-flex align-items-center justify-content-center z-20"
    >
      <SvgIcon
        icon="edit"
        class="p-2 mr-2 bg-edit button cursor-pointer rounded-md"
        @click="updateCourse()"
      />
      <SvgIcon
        icon="delete"
        class="p-2 bg-delete button cursor-pointer rounded-md"
        @click="deleteCourse()"
      />
    </div>

    <div
      class="card-image relative"
      @mouseover="changeIsHover(true)"
      @mouseout="changeIsHover(false)"
    >
      <img :src="course.image ? course.image : 'https://www.masaischool.com/blog/content/images/2023/03/Object-oriented-programming-blog.png'" :alt="course.title" class="rounded" />
      <div
        class="absolute top-0 left-0 bg-dark rounded transition-all w-100 h-100"
        :class="isHover ? 'opacity-40' : 'opacity-0'"
      ></div>
      <router-link
        :to="`/course/${course?._id}`"
        ref="btnCouse"
        class="btn btn-white btn-course !font-[600] !rounded-xl absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2"
        :class="isHover ? 'opacity-100' : 'opacity-0'"
      >
        Xem khóa học
      </router-link>
    </div>
    <div class="card-content mt-2">
      <div class="media">
        <div class="media-content">
          <p class="title font-bold m-0 text-left">{{ course.title }}</p>
          <div class="price flex items-center">
            <p class="subtitle text-gray-500 line-through my-0">
              {{ course.price ? formatMoney(course.price) : 0 }}đ
            </p>
            <p class="subtitle text-red-700 my-0 ml-2">
              {{ course.discount ? formatMoney((100 - course.discount) * course.price / 100) : formatMoney(course?.price) || 0 }}đ
            </p>
          </div>
          <div
            v-if="getUserInfo()?.role !== 'mentor'"
            class="flex items-center"
          >
            <button
              class="absolute right-2 bottom-4 btn btn-primary btn-course"
              @click="buyCourse(course._id, course.price, course.discount)"
            >
              {{ course.price > 0 ? "Mua khóa học" : "Free" }}
            </button>
            <img
              :src="course?.creator?.avatar"
              :alt="course?.creator?.name"
              class="rounded-full w-8 h-8"
            />
            <p class="subtitle text-gray-500 ml-2 mt-3">
              {{ course.creator.name }}
            </p>
          </div>
          <div v-else>
            <p class="subtitle text-gray-500 my-0">
              {{ course.user_count ? course.user_count : 0 }} học viên
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts">
import { ref } from "vue";
import { getUserInfo } from "../../ultils/cache/cookies";
import CourseModal from "../../pages/Course/CourseModal.vue";
import SvgIcon from "../BUI/SvgIcon/SvgIcon.vue";
import SwalPopup from "../../ultils/swalPopup";
import { Course } from "../../types/course";
import { useCourse } from "../../stores/course";
import { useRouter } from "vue-router";

export default {
  name: "CourseCard",
  components: {
    CourseModal,
    SvgIcon,
  },
  props: {
    course: {
      type: Object || String,
      required: true,
    },
  },
  emits: ["updateCourse", "deleteCourse"],
  setup(props, { emit }) {
    const isHover = ref(false);
    const urlPayment = ref("");
    const router = useRouter();

    const changeIsHover = (value: boolean) => {
      isHover.value = value;
    };

    const updateCourse = () => {
      emit("updateCourse", props?.course);
    };

    const deleteCourse = () => {
      SwalPopup.swalDeletePopup(
        "",
        {
          onConfirmed: () => {
            emit("deleteCourse", props?.course?._id);
          },
        },
        {
          html:
            "Bạn có chắc chắn xóa khóa học " +
            `<span class="color-primary">${props?.course?.title}</span>` +
            " ?",
        }
      );
    };

    const buyCourse = (courseId, price, discount) => {
      if (price == 0 || discount == 100) {
        SwalPopup.swalResultPopup("Bạn đã đăng ký khóa học thành công!", "success");
        router.push(`/course/${courseId}`);
        
        return;
      }
      SwalPopup.swalDeletePopup(
        "",
        {
          onConfirmed: () => {
            useCourse().requestBuyCourse({
              params: {
                course: courseId,
              },
              callback: {
                onSuccess: (response) => {
                  urlPayment.value = response.url;
                  window.open(response.url, "_blank");
                },
                onFailure: () => {
                  console.log("err");
                },
              },
            });
          },
        },
        {
          confirmButtonText: "Ok",
          html:
            "Bạn có chắc chắn mua khóa học " +
            `<span class="color-primary">${props?.course?.title}</span>` +
            " ?",
        }
      );
    };

    const formatMoney = (money: number) => {
      return money.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.");
    };

    return {
      isHover,
      deleteCourse,
      updateCourse,
      changeIsHover,
      getUserInfo,
      buyCourse,
      formatMoney,
    };
  },
};
</script>
<style scoped lang="css">
.card {
  width: 300px;
  height: 260px;
}

.card-image {
  height: 200px;
  overflow: hidden;
}

.card-image img {
  object-fit: cover;
  width: 100%;
  height: 100%;
}

.btn-course {
  animation-duration: 1s;
  animation-fill-mode: forwards;
}

.bg-edit {
  background-color: #17a2b8;
}

.bg-delete {
  background-color: #dc3545;
}
</style>
