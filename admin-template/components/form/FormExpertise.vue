<template>
  <div>
    <form
      class="form-wrapper mx-auto"
      method="POST"
      @submit.prevent="onSubmit()"
    >
      <div class="row">
        <div class="col-md-6">
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
        </div>
      </div>
      <div class="row">
        <div class="col-12">
          <div class="form-group">
            <button type="submit" class="btn-custom btn-blue">Create</button>
          </div>
        </div>
      </div>
    </form>
  </div>
</template>
<script>
export default {
  name: "FormExpertise",
  props: {
    submit: {
      type: Function,
      default: () => {},
    },
  },

  data() {
    return {
      expertiseList: [],
      selectedOption: null,
      expertise: {
        name: "",
      },
    };
  },
  mounted() {
    this.getListExpertise();
  },
  methods: {
    getListExpertise() {
      this.$api.contact.getListSearchExpertise().then((res) => {
        this.expertiseList = res?.data
          ? res?.data?.map((item) => {
              return {
                id: item._id,
                title: item.name,
              };
            })
          : [];
      });
      this.$router.push({ query: this.params });
    },
    async onSubmit() {
      this.$api.contact
        .addExpertise(this.expertise)
        .then((res) => {
          this.$toast.success("Create succesfully!", {
            className: "my-toast",
          });
          this.$router.push("/expertise");
        })
        .catch(() => {
          this.$toast.error("Create failed!", {
            className: "my-toast",
          });
        });
    },
  },
};
</script>
<style lang="scss" scoped>
.form-group {
  label {
    font-size: 14px;
  }
  input {
    &::placeholder {
      color: $color-secondary;
    }
  }
  textarea {
    &::placeholder {
      color: $color-secondary;
    }
  }
}
</style>
