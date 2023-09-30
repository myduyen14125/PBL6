<template>
  <div class="h-100 position-relative">
    <div class="header d-flex justify-content-between">
      <div class="d-flex align-items-center">
        <img src="@/assets/icons/icon-back.svg" alt="" width="20px" height="20px" class="mr-1 cursor-pointer" @click="goBack()">
        <h1 class="title">Activity detail</h1>
      </div>
      <button class="btn-custom btn-blue" @click="goToUpdate(activity.id)">
        Update
      </button>
    </div>
    <hr class="my-2">
    <div class="content">
     <div class="d-flex align-items-center mb-2">
      <img class="content-image mr-3" :src="activity.thumbnail_url" alt="">
      <h1 v-if="activity.title" class="title w-60 break-word white-space">{{ activity.title.trim() }}</h1>
     </div>
     <ul>
        <li class="list-item px-3 py-2 d-flex">
          <div class="content-title w-95px mr-3">Created at:</div>
          <div class="content-desc">{{ formatDateTime(activity.created_at) }}</div>
        </li>
        <li class="list-item px-3 py-2 d-flex align-items-center h-57">
          <div class="content-title mr-3 w-95px">Published</div>
          <div class="switch-toggle">
            <label class="switch">
              <input v-model="activity.published" type="checkbox" @click="markPublic()">
              <span class="slider round"></span>
            </label>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
import moment from 'moment';
export default {
  name: 'Contact',
  layout: 'secret',
  data() {
    return {
      activity: {},
    }
  },
  created() {
    this.$api.activity.getActivityById(this.$route.params.id)
    .then((res) => {
      this.activity = res.data.data
    })
  },
  methods: {
    goBack() {
      this.$router.go(-1);
    },
    goToUpdate(id) {
      this.$router.push(`/activity/${id}/update`)
    },
    markPublic() {
      this.$api.activity.markPublicActivity(this.activity.id)
        .then((res) => {
          this.$toast.success('Change status public successfully!', {
            className: 'my-toast',
          })
        })
    },
    formatDateTime(date) {
      return moment(date).format('DD.MM.YYYY HH:mm');
    }
  }
}
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
    border-radius: 6px;
  }
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
  }
}
.w-95px {
  width: 110px !important;
}
</style>