<template>
  <div class="position-relative h-100">
    <div class="header d-flex justify-content-between">
      <div class="d-flex align-items-center">
        <img src="@/assets/icons/icon-back.svg" alt="" width="20px" height="20px" class="mr-1 cursor-pointer" @click="goBack()">
        <h1 class="title">Service detail</h1>
      </div>
    </div>
    <hr class="mt-2 mb-1">
    <div class="content">
      <div class="created-at d-flex bg-gray px-4 py-2 align-items-center h-38">
        <div class="content-title w-auto mr-3">Created at: </div>
        <div class="content-desc">{{ formatDateTime(service.created_at) }}</div>
      </div>
      <ul>
        <li class="list-item px-4 py-2 d-flex min-h-48">
          <div class="content-title mr-3">Name</div>
          <div v-if="service.name" class="content-desc">{{ service.name.trim() }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex min-h-48">
          <div class="content-title mr-3">Email</div>
          <div class="content-desc">{{ service.email }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex h-48">
          <div class="content-title mr-3">Phone</div>
          <div class="content-desc">{{ service.phone }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex h-48">
          <div class="content-title mr-3">Position</div>
          <div class="content-desc">{{ getCategoryName(service.category_id) }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex min-h-48">
          <div class="content-title mr-3">Content</div>
          <div class="content-desc">{{ service.content }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex h-48">
          <div class="content-title mr-3">Status</div>
          <div 
            class="content-desc w-auto status"
            :class="{
              'status-done': service.status === 'DONE',
              'status-doing': service.status === 'DOING',
              'status-todo': service.status === 'TODO'
            }">{{ service.status }}</div>
        </li>
        <button
          v-if="service.status === 'TODO'"
          class="btn-custom btn-blue mt-4 ml-4" @click="openModal">
            Mark DOING
        </button>
        <button
          v-if="service.status === 'DOING'"
          class="btn-custom btn-blue mt-4 ml-4" @click="openModal">
            Mark DONE
        </button>
      </ul>
    </div>
    <BaseModal
      v-if="showModal"
      :title="'Confirm'"
      :description=' service.status === "TODO" ? "Would you like to confirm doing status?" : "Would you like to confirm done status?"'
      :function-text="'Confirm'"
      @function-action="changeStatus(service.status)"
      @close="closeModal"
    >
    </BaseModal>
  </div>
</template>
<script>
import moment from 'moment';
import { mapActions, mapGetters } from 'vuex';
import BaseModal from '~/components/modal/BaseModal.vue';

export default {
  name: 'Application',
  components: {
    BaseModal
  },
  layout: 'secret',
  data() {
    return {
      service: {},
      showModal: false
    }
  },
  computed: {
    ...mapGetters({
      categoryList: 'serviceCategory/getCategories'
    })
  },
  created() {
    this.$api.service.getServiceById(this.$route.params.id)
    .then((res) => {
      this.service = res.data.data
    })
  },
  methods: {
    ...mapActions({
      fetchCategoryList: 'serviceCategory/fetchList'
    }),
    getCategoryName(id) {
      const category = this.categoryList.find(item => item.id === id);
      return category ? category.title : '-';
    },
    changeStatus(status) {
      if (status === 'TODO') {
        this.$api.service.markDoingService(this.$route.params.id)
        .then((res) => {
          this.service.status = 'DOING'
          this.showModal = false
        })
        .then((res) => {
          this.$toast.success('Confirm status successfully!', {
            className: 'my-toast',
          })
        })
      } 
      else if (status === 'DOING') {
        this.$api.service.markDoneService(this.$route.params.id)
        .then((res) => {
          this.service.status = 'DONE'
          this.showModal = false
        })
        .then((res) => {
          this.$toast.success('Confirm status successfully!', {
            className: 'my-toast',
          })
        })
      }
    },
    goBack() {
      this.$router.go(-1);
    },
    formatDateTime(date) {
      return moment(date).format('DD.MM.YYYY HH:mm');
    },
    openModal() {
      this.showModal = true; 
    },
    closeModal() {
      this.showModal = false; 
    },
  }
}
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