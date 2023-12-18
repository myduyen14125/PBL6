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
          @click="$router.go(-1)"
        />
        <h1 class="title">Mentor detail</h1>
      </div>
      <button class="btn-custom btn-blue" @click="goToUpdate(blog.id)">
        Update
      </button>
    </div>
    <div>
      <div class="card mb-3 w-100">
        <div class="row g-0">
          <div class="col-md-4 d-flex align-items-start justify-content-center">
            <img
              v-if="mentor?.avatar"
              :src="mentor?.avatar"
              :width="160"
              :height="160"
              class="img-fluid rounded-circle my-4 object-cover"
              alt="..."
            />
          </div>
          <div class="col-md-8">
            <div class="card-body">
              <h5 class="card-title">{{ mentor?.name }}</h5>
              <p
                class="d-flex align-items-start justify-content-center card-text"
              >
                <span class="w-25">Email:</span>
                <span class="w-75">{{ mentor?.email }}</span>
              </p>
              <p
                class="d-flex align-items-start justify-content-center card-text"
              >
                <span class="w-25">Expertise:</span>
                <span class="w-75">{{ mentor?.expertise?.name }}</span>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import moment from "moment";

export default {
  name: "MentorDetails",
  layout: "secret",
  data() {
    return {
      mentor: {},
    };
  },
  mounted() {
    this.getMentorDetail();
  },
  methods: {
    getMentorDetail() {
      this.$api.contact.getMentorDetails(this.$route.params.id).then((res) => {
        this.mentor = res?.data;
      });
    },
    goToUpdate(id) {
      this.$router.push(`/mentor/${id}/update`);
    },
    formatDate(date) {
      return moment(date).format("DD/MM/YYYY");
    },
  },
};
</script>
<style lang="scss" scoped>
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
