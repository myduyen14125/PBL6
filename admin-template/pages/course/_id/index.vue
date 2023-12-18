<template>
  <div>
    <div class="header d-flex justify-content-between">
      <div class="d-flex align-items-center">
        <img
          src="@/assets/icons/icon-back.svg"
          alt=""
          width="20px"
          height="20px"
          class="mr-1 cursor-pointer"
          @click="goBack()"
        />
        <h1 class="title">Course detail</h1>
      </div>
    </div>
    <hr class="mt-2 mb-1" />
    <div class="content overflow-auto h-90">
      <ul>
        <li class="list-item px-4 py-2 d-flex min-h-48">
          <div class="content-title mr-3">Image</div>
          <div v-if="course.image" class="content-desc">
            <img v-if="course?.image" class="avatar" :src="course?.image" />
          </div>
        </li>
        <li class="list-item px-4 py-2 d-flex min-h-48">
          <div class="content-title mr-3">Title</div>
          <div v-if="course.title" class="content-desc">
            {{ course.title.trim() }}
          </div>
        </li>
        <li class="list-item px-4 py-2 d-flex min-h-48">
          <div class="content-title mr-3">Description</div>
          <div class="content-desc">{{ course.description }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex h-48">
          <div class="content-title mr-3">Price</div>
          <div class="content-desc">{{ course.price }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex min-h-48">
          <div class="content-title mr-3">Duration</div>
          <div class="content-desc w-60">{{ course.duration }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex min-h-48">
          <div class="content-title mr-3">Creator</div>
          <div class="content-desc w-60">{{ name }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex min-h-48">
          <div class="content-title mr-3">Number of students</div>
          <div class="content-desc w-60">{{ course.user_count }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex min-h-48">
          <div class="content-title mr-3">Number of lessons</div>
          <div class="content-desc w-60">{{ course.lesson_count }}</div>
        </li>

        <button
          v-if="course.status === 'TODO'"
          class="btn-custom btn-blue mt-4 ml-4"
          @click="openModal"
        >
          Mark DOING
        </button>
        <button
          v-if="course.status === 'DOING'"
          class="btn-custom btn-blue mt-4 ml-4"
          @click="openModal"
        >
          Mark DONE
        </button>
      </ul>
    </div>
    <BaseModal
      v-if="showModal"
      :title="'Confirm'"
      :description="
        course.status === 'TODO'
          ? 'Would you like to confirm doing status?'
          : 'Would you like to confirm done status?'
      "
      :function-text="'Confirm'"
      @function-action="changeStatus(course.status)"
      @close="closeModal"
    >
    </BaseModal>
  </div>
</template>
<script>
import moment from "moment";
import { mapActions, mapGetters } from "vuex";
import BaseModal from "~/components/modal/BaseModal.vue";

export default {
  name: "CourseDetail",
  components: {
    BaseModal,
  },
  layout: "secret",
  data() {
    return {
      course: {},
      name: "",
      showModal: false,
    };
  },
  computed: {
    // ...mapGetters({
    //   subjectList: "subject/getSubjects",
    // }),
  },
  created() {
    // this.$api.contact.getListMentee().then((res) => {
    //   this.course = res.data.data;
    // });
    // let menteeList;
    this.$api.contact.getListCourse().then((res) => {
      console.log("res", res.data.mentees);
      for (const course of res.data.courses) {
        if (course._id == this.$route.params.id) {
          this.course = course;
          this.name = course.creator.name;
          break;
        } else {
          this.course = [];
        }
      }
    });
  },
  methods: {
    ...mapActions({
      fetchSubjectList: "subject/fetchList",
    }),
    getSubjectName(id) {
      const subject = this.subjectList.find((item) => item.id === id);
      return subject ? subject.title : "-";
    },
    changeStatus(status) {
      if (status === "TODO") {
        this.$api.contact
          .markDoingContact(this.$route.params.id)
          .then((res) => {
            this.course.status = "DOING";
            this.showModal = false;
          })
          .then((res) => {
            this.$toast.success("Confirm contact successfully!", {
              className: "my-toast",
            });
          });
      } else if (status === "DOING") {
        this.$api.contact
          .markDoneContact(this.$route.params.id)
          .then((res) => {
            this.course.status = "DONE";
            this.showModal = false;
          })
          .then((res) => {
            this.$toast.success("Confirm contact successfully!", {
              className: "my-toast",
            });
          });
      }
    },
    goBack() {
      this.$router.go(-1);
    },
    formatDateTime(date) {
      return moment(date).format("DD.MM.YYYY HH:mm");
    },
    openModal() {
      this.showModal = true;
    },
    closeModal() {
      this.showModal = false;
    },
  },
};
</script>
<style lang="scss" scoped>
.avatar {
  width: 100px;
  height: 100px;
  border-radius: 50%;
}
.content {
  &-title {
    font-weight: 500;
    color: $color-primary;
    width: 236px;
  }
  &-desc {
    color: $color-secondary;
    // width: calc(100% - 236px - 50px);
    width: 60%;
    text-align: justify;
    word-break: break-word;
  }
}
</style>
