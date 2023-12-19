<!-- eslint-disable vue/no-v-html -->
<template>
  <div class="h-100 position-relative pb-5">
    <div class="header d-flex justify-content-between">
      <div class="d-flex align-items-center">
        <img src="@/assets/icons/icon-back.svg" alt="" width="20px" height="20px" class="mr-1 cursor-pointer"
          @click="$router.go(-1)" />
        <h1 class="title">Blog detail</h1>
      </div>
      <button class="btn-custom btn-blue" @click="goToUpdate(blog.id)">
        Update
      </button>
    </div>
    <hr class="my-2" />
    <div class="content">
      <div class="d-flex align-items-center">
        <h1 v-if="blog.title" class="title w-60 break-word">
          {{ blog.title.trim() }}
        </h1>
      </div>
      <div class="d-flex align-items-center py-3">
        <img :src="blog?.user?.avatar || ''" class="avatar-img mx-3" />
        <div>
          <p class="author mb-0">{{ blog?.user?.name || "" }}</p>
          <p class="job mb-1">Mentor tại IT Mentor</p>
          <p class="mb-0">
            {{ `Đăng ngày ${formatDate(blog?.createdAt) || ""}` }}
          </p>
        </div>
      </div>
      <div class="mb-5">
        <img v-if="blog.image" class="content-image w-100" :src="blog.image" alt="" />
      </div>
      <div v-html="blog.content"></div>
    </div>
  </div>
</template>
<script>
import moment from "moment";

export default {
  name: "BlogDetail",
  layout: "secret",
  data() {
    return {
      blog: {},
    };
  },
  created() {
    this.getBlogDetail();
  },
  mounted() { },
  methods: {
    getBlogDetail() {
      this.$api.contact.getBlogById(this.$route.params.id).then((res) => {
        this.blog = res?.data;
      });
    },
    goToUpdate(id) {
      this.$router.push(`/blog/${id}/update`);
    },
    formatDate(date) {
      return moment(date).format("DD/MM/YYYY");
    },
  },
};
</script>
<style lang="scss" scoped>
@import "@/assets/scss/toggle.scss";

.content {
  overflow: auto;
  height: 90%;

  &-image {
    width: 263px;
    height: 200px;
    object-fit: cover;
    border-radius: 10px;

    &-detail {
      width: 780px;
      height: 248.38px;
      object-fit: cover;
      border-radius: 10px;
    }
  }

  &-title {
    font-weight: 500;
    color: $color-primary;
    width: 296px;
  }

  &-desc {
    color: $color-secondary;
    // width: calc(100% - 236px - 50px);
    width: 60% !important;
    text-align: justify;
    // margin-left: 14px;
  }
}

::v-deep .html-content {
  padding: 0;

  img {
    max-width: 100%;
    height: auto;
  }
}

.w-90px {
  width: 120px;
}

.avatar-img {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  object-fit: cover;
}

.author {
  font-weight: 600;
  color: $color-primary;
}

.job {
  color: #949ba1;
}
</style>
