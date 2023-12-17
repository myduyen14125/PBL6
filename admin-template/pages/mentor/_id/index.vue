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
        <h1 class="title">Contact detail</h1>
      </div>
    </div>
    <hr class="mt-2 mb-1" />
    <div class="content overflow-auto h-90">
      <div class="created-at d-flex bg-gray px-4 py-2 align-items-center h-38">
        <div class="content-title w-auto mr-3">Created at:</div>
        <div class="content-desc">{{ formatDateTime(person.created_at) }}</div>
      </div>
      <ul>
        <li class="list-item px-4 py-2 d-flex min-h-48">
          <div class="content-title mr-3">Name</div>
          <div v-if="person.name" class="content-desc">
            {{ person.name.trim() }}
          </div>
        </li>
        <li class="list-item px-4 py-2 d-flex min-h-48">
          <div class="content-title mr-3">Email</div>
          <div class="content-desc">{{ person.email }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex h-48">
          <div class="content-title mr-3">Phone</div>
          <div class="content-desc">{{ person.phone }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex min-h-48">
          <div class="content-title mr-3">Content</div>
          <div class="content-desc w-60">{{ person.content }}</div>
        </li>
        <li class="list-item px-4 py-2 d-flex h-48">
          <div class="content-title mr-3">Subject</div>
          <div class="content-desc">
            {{ getSubjectName(person.subject_id) }}
          </div>
        </li>
        <li class="list-item px-4 py-2 d-flex h-48">
          <div class="content-title mr-3">Status</div>
          <div
            class="content-desc w-auto status"
            :class="{
              'status-done': person.status === 'DONE',
              'status-doing': person.status === 'DOING',
              'status-todo': person.status === 'TODO',
            }"
          >
            {{ person.status }}
          </div>
        </li>
        <button
          v-if="person.status === 'TODO'"
          class="btn-custom btn-blue mt-4 ml-4"
          @click="openModal"
        >
          Mark DOING
        </button>
        <button
          v-if="person.status === 'DOING'"
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
        person.status === 'TODO'
          ? 'Would you like to confirm doing status?'
          : 'Would you like to confirm done status?'
      "
      :function-text="'Confirm'"
      @function-action="changeStatus(person.status)"
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
  name: "MentorDetail",
  components: {
    BaseModal,
  },
  layout: "secret",
  data() {
    return {
      person: {},
      showModal: false,
    };
  },
  computed: {
    ...mapGetters({
      subjectList: "subject/getSubjects",
    }),
  },
  created() {
    this.$api.contact.getContactById(this.$route.params.id).then((res) => {
      this.person = res.data.data;
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
            this.person.status = "DOING";
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
            this.person.status = "DONE";
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
