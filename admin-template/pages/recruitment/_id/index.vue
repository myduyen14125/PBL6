<template>
  <div class="position-relative h-100">
    <div class="header d-flex justify-content-between">
      <div class="d-flex align-items-center">
        <img src="@/assets/icons/icon-back.svg" alt="" width="20px" height="20px" class="mr-1 cursor-pointer" @click="goBack()">
        <h1 class="title">Recruitment application detail</h1>
      </div>
    </div>
    <hr class="mt-2 mb-1">
    <div class="content">
      <div class="d-flex bg-gray px-4 py-2 align-items-center h-38">
        <div class="content-title w-auto mr-3">Applied at: </div>
        <div class="content-desc">{{ formatDateTime(application.created_at) }}</div>
      </div>
      <ul>
        <li class="list-item px-4 py-2 d-flex min-h-48">
          <div class="content-title mr-3">Name</div>
          <div v-if="application.full_name" class="content-desc">{{ application.full_name.trim() }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex min-h-48">
          <div class="content-title mr-3">Email</div>
          <div class="content-desc">{{ application.email }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex h-48">
          <div class="content-title mr-3">Phone</div>
          <div class="content-desc">{{ application.phone }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex h-48">
          <div class="content-title mr-3">Position</div>
          <div class="content-desc">{{ getPositionName(application.position_id) }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex">
          <div class="content-title mr-3">Link CV</div>
          <div class="content-desc">{{ application.link_cv }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex">
          <div class="content-title mr-3">Cover letter</div>
          <div class="content-desc">{{ application.cover_letter }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex">
          <div class="content-title mr-3">Proof of quality</div>
          <div class="content-desc">{{ application.proof_of_quality }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex h-48">
          <div class="content-title mr-3">Status</div>
          <div 
            class="content-desc w-auto status"
            :class="{
              'status-done': application.status === 'DONE',
              'status-doing': application.status === 'DOING',
              'status-todo': application.status === 'TODO'
            }">{{ application.status }}</div>
        </li>
        <button
          v-if="application.status === 'TODO'"
          class="btn-custom btn-blue mt-4 ml-4" @click="openModal">
            Mark DOING
        </button>
        <button
          v-if="application.status === 'DOING'"
          class="btn-custom btn-blue mt-4 ml-4" @click="openModal">
            Mark DONE
        </button>
      </ul>
    </div>
    <BaseModal
      v-if="showModal"
      :title="'Confirm'"
      :description=' application.status === "TODO" ? "Would you like to confirm doing status?" : "Would you like to confirm done status?"'
      :function-text="'Confirm'"
      @function-action="changeStatus(application.status)"
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
      application: {},
      showModal: false
    }
  },
  computed: {
    ...mapGetters({
      positionList: 'position/getPositions'
    })
  },
  created() {
    this.$api.application.getApplicationById(this.$route.params.id)
    .then((res) => {
      this.application = res.data.data
    })
  },
  methods: {
    ...mapActions({
      fetchPositionList: 'position/fetchList'
    }),
    getPositionName(id) {
      const position = this.positionList.find(item => item.id === id);
      return position ? position.title : '-';
    },
    changeStatus(status) {
      if (status === 'TODO') {
        this.$api.application.markDoingApplication(this.$route.params.id)
        .then((res) => {
          this.application.status = 'DOING'
          this.showModal = false;
        })
        .then((res) => {
          this.$toast.success('Confirm status successfully!', {
            className: 'my-toast',
          })
        })
      } 
      else if (status === 'DOING') {
        this.$api.application.markDoneApplication(this.$route.params.id)
        .then((res) => {
          this.application.status = 'DONE'
          this.showModal = false;
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
  overflow: auto;
  height: 90%;
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