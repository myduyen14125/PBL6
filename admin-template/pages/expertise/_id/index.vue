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
        <h1 class="title mx-2">Expertise detail</h1>
      </div>
    </div>
    <hr class="mt-2 mb-1" />
    <div class="content overflow-auto h-90">
      <div class="form-group color-primary">
        <label for="name">
          Name
          <span class="text-danger __label">*</span>
        </label>
        <input
          v-model="expertise.name"
          type="text"
          class="form-control color-secondary w-100"
          name="name"
          placeholder="Enter expertise"
          required
        />
      </div>
      <div class="form-group">
        <button
          type="submit"
          class="btn-custom btn-blue"
          @click="updateExpertise()"
        >
          Update
        </button>

        <!-- <button
          type="submit"
          class="btn-custom"
          @click="delExpertise()"
        >
          Delete
        </button> -->
      </div>
    </div>
  </div>
</template>
<script>
import BaseModal from "~/components/modal/BaseModal.vue";

export default {
  name: "ExpertiseDetail",
  components: {},
  layout: "secret",
  data() {
    return {
      person: {},
      showModal: false,
      expertiseList: [],
      expertise: "",
    };
  },
  computed: {},
  created() {
    this.$api.contact.getListSearchExpertise().then((res) => {
      this.expertiseList = res.data || [];
      console.log("res.data", res.data);
      for (const expertise of res.data) {
        if (expertise._id == this.$route.params.id) {
          this.expertise = expertise;
          console.log(" this.expertise", expertise);

          break;
        } else {
          this.expertise = [];
        }
      }
    });
  },
  methods: {
    updateExpertise() {
      console.log(" expertise", this.expertise);

      this.$api.contact
        .updateExpertise(this.expertise)
        .then((res) => {
          this.$toast.success("Update succesfully!", {
            className: "my-toast",
          });
          this.$router.push("/expertise");
        })
        .catch(() => {});
    },
    delExpertise() {
      console.log(" expertisedel", this.expertise);

      this.$api.contact
        .deleteExpertise(this.expertise._id)
        .then((res) => {
          if (res.data.deletedCount != 0) {
            this.$toast.success("Delete succesfully!", {
              className: "my-toast",
            });
            this.$router.push("/expertise");
          }
        })
        .catch(() => {});
    },

    goBack() {
      this.$router.go(-1);
    },
    formatDateTime(date) {
      return moment(new Date(date)).format("DD.MM.YYYY HH:mm");
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
