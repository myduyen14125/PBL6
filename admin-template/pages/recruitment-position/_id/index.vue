<template>
  <div class="h-100 position-relative">
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
        <h1 class="title">Application position detail</h1>
      </div>
    </div>
    <hr class="my-2" />
    <div class="content">
      <ul>
        <li class="list-item px-3 py-2 d-flex">
          <div class="content-title mr-3">Position:</div>
          <div v-if="position.title" class="content-desc">
            {{ position.title.trim() }}
          </div>
        </li>
        <li class="list-item px-3 py-2 d-flex">
          <div class="content-title mr-3">ID:</div>
          <div class="content-desc">{{ position.id }}</div>
        </li>
        <li class="list-item px-3 py-2 d-flex">
          <div class="content-title mr-3">Created at:</div>
          <div class="content-desc">
            {{ formatDateTime(position.created_at) }}
          </div>
        </li>
      </ul>
      <button class="btn-custom btn-white mt-4 mr-2-5" @click="openModal">
        Delete
      </button>
      <button class="btn-custom btn-blue" @click="goToUpdate(position.id)">
        Update
      </button>
    </div>
    <BaseModal
      v-if="showModal"
      :title="'Delete recruitments position'"
      :description="'Do you want to delete this Position?'"
      :function-text="'Delete'"
      @function-action="removeItem(position.id)"
      @close="closeModal"
    >
    </BaseModal>
  </div>
</template>
<script>
import moment from "moment";
import BaseModal from "~/components/modal/BaseModal.vue";

export default {
  name: "RecruitmentPositionDetail",
  components: {
    BaseModal,
  },
  layout: "secret",
  data() {
    return {
      position: {},
      showModal: false,
    };
  },
  created() {
    this.$api.position.getPositionById(this.$route.params.id).then((res) => {
      this.position = res.data.data;
    });
  },
  methods: {
    goBack() {
      this.$router.go(-1);
    },
    goToUpdate(id) {
      this.$router.push(`/recruitment-position/${id}/update`);
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
    removeItem(id) {
      this.$api.position
        .deletePosition(id)
        .then((res) => {
          this.$toast.success("Delete recruitment position successfully!", {
            className: "my-toast",
          });
        })
        .then((res) => {
          this.$router.push("/recruitment-position");
        });
    },
  },
};
</script>
<style lang="scss" scoped>
.content {
  overflow: auto;
  height: 100%;
  &-image {
    width: 263px;
    height: 127px;
    object-fit: cover;
    border-radius: 6px;
  }
  &-title {
    font-weight: 500;
    color: $color-primary;
    width: 124px;
  }
  &-desc {
    color: $color-secondary;
    // width: calc(100% - 236px - 50px);
    width: 60%;
    text-align: justify;
  }
}
</style>
