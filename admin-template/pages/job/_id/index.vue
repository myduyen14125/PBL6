<template>
  <div class="h-100 position-relative">
    <div class="header d-flex justify-content-between">
      <div class="d-flex align-items-center">
        <img src="@/assets/icons/icon-back.svg" alt="" width="20px" height="20px" class="mr-1 cursor-pointer" @click="goBack()">
        <h1 class="title">Job detail</h1>
      </div>
      <button class="btn-custom btn-blue" @click="goToUpdate(job.id)">
        Update
      </button>
    </div>
    <hr class="my-2" />
    <div class="content">
      <h1 v-if="job.title" class="title ml-4 mb-4 mt-3 break-word">{{ job.title.trim() }}</h1>
      <ul>
        <li class="list-item py-2 d-flex align-items-center h-38">
          <div class="content-title ml-4 w-90px mr-3">Created at:</div>
          <div class="content-desc">{{ formatDateTime(job.created_at) }}</div>
        </li>
        <li class="list-item py-2 d-flex align-items-center h-38">
          <div class="color-yellow content-title ml-4 w-90px mr-3">Publish at:</div>
          <div class="content-desc">
            {{ job.published_at ? formatDateTime(job.published_at) : '-' }}
          </div>
        </li>
        <li class="list-item py-2 d-flex h-57">
          <div class="content-title ml-4 mr-3">Type</div>
          <div v-if="job.working_type" class="content-desc">
            {{ formatWorkingType(job.working_type) }}
          </div>
        </li>
        <li class="list-item py-2 d-flex min-h-57">
          <div class="content-title ml-4 mr-3">Address</div>
          <div class="content-desc">
            {{ job.address }}
          </div>
        </li>
        <li class="list-item py-2 d-flex h-57">
          <div class="content-title ml-4 mr-3">Salary</div>
          <div v-if="job.salary" class="content-desc">{{ formatSalary(job.salary) }}</div>
        </li>
        <li class="list-item py-2 d-flex min-h-57">
          <div class="content-title ml-4 mr-3">Introduction</div>
          <div class="content-desc">{{ job.introduction }}</div>
        </li>
        <li class="list-item py-2 d-flex h-57">
          <div class="content-title ml-4 mr-3">Deadline</div>
          <div class="content-desc">{{ formatDate(job.deadline) }}</div>
        </li>
        <li class="list-item py-2 d-flex min-h-57">
          <div class="content-title ml-4 mr-3">Responsibilities</div>
          <ul class="content-desc">
            <li v-for="item in job.responsibilities" :key="item.id" class="pr-0">
              {{ item }}
            </li>
          </ul>
        </li>
        <li class="list-item py-2 d-flex min-h-57">
          <div class="content-title ml-4 mr-3">Requirements</div>
          <ul class="content-desc">
            <li v-for="item in job.requirements" :key="item.id" class="pr-0">
              {{ item }}
            </li>
          </ul>
        </li>
        <li class="list-item py-2 d-flex min-h-57">
          <div class="content-title ml-4 mr-3">Benefits</div>
          <ul class="content-desc">
            <li v-for="item in job.benefits" :key="item.id" class="pr-0">
              {{ item }}
            </li>
          </ul>
        </li>
        <li class="list-item py-2 d-flex">
          <div class="content-title ml-4 mr-3">Published</div>
          <div class="switch-toggle">
            <label class="switch">
              <input v-model="job.published" type="checkbox" @click="markPublic()">
              <span class="slider round"></span>
            </label>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
import moment from 'moment'
export default {
  name: 'Contact',
  layout: 'secret',
  data() {
    return {
      job: {},
    }
  },
  created() {
    this.$api.job.getJobById(this.$route.params.id).then((res) => {
      this.job = res.data.data
    })
  },
  methods: {
    goBack() {
      this.$router.go(-1)
    },
    goToUpdate(id) {
      this.$router.push(`/job/${id}/update`)
    },
    markPublic() {
      this.$api.job.markPublicJob(this.job.id)
        .then((res) => {
          this.$toast.success('Change status public successfully!', {
            className: 'my-toast',
          })
        })
    },
    formatDateTime(date) {
      return moment(date).format('DD.MM.YYYY HH:mm');
    },
  },
}
</script>
<style lang="scss" scoped>
@import "@/assets/scss/toggle.scss";
.title {
  padding-right: 18px;
  justify-content: justify;
}

.content {
  overflow: auto;
  height: 90%;
  &-title {
    font-weight: 500;
    color: $color-primary;
    width: 296px;
  }
  &-desc {
    color: $color-secondary;
    width: calc(100% - 296px - 24px - 22px);
    // width: 60%;
    padding-right: 18px;
    text-align: justify;
    word-break: break-word;
    li {
      list-style: inside;
    }
  }
}
.w-90px {
  width: 120px;
}
</style>