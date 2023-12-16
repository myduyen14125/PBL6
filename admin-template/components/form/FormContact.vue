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
              v-model="data.name"
              type="text"
              class="form-control color-secondary w-100"
              name="name"
              placeholder="Enter your name"
              required
            />
          </div>
          <div class="form-group color-primary mt-4">
            <label for="phone">
              Phone
              <span class="text-danger __label">*</span>
            </label>
            <input
              v-model="data.phone"
              type="text"
              class="form-control color-secondary w-100"
              name="phone"
              placeholder="Enter your phone"
              required
            />
          </div>
          <div class="form-group color-primary mt-4">
            <label for="content">
              Message
              <span class="text-danger __label">*</span>
            </label>
            <textarea
              v-model="data.content"
              class="form-control color-secondary w-100"
              name="message"
              rows="5"
              placeholder="Enter your message"
              required
            ></textarea>
          </div>
        </div>

        <!-- Col right -->
        <div class="col-md-6">
          <div class="form-group color-primary">
            <label for="email">
              Email
              <span class="text-danger __label">*</span>
            </label>
            <input
              v-model="data.email"
              type="email"
              class="form-control color-secondary w-100"
              name="email"
              placeholder="Enter your email"
              required
            />
          </div>
          <!-- Select subject -->
          <div class="form-group color-primary mt-4">
            <label for="role"
              >Subject <span class="text-danger __label">*</span></label
            >
            <v-select
              v-model="selectedOption"
              class="style-chooser w-100"
              placeholder="Choose Subject"
              :options="
                expertiseList.map((item) => ({
                  value: item.id,
                  label: item.title,
                }))
              "
            />
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-12">
          <div class="form-group">
            <button type="submit" class="btn-custom btn-blue">
              Submit form
            </button>
          </div>
          <!-- Button submit -->
        </div>
      </div>
    </form>
  </div>
</template>
<script>
export default {
  name: "FormContact",
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
      data: {
        name: "",
        email: "",
        phone: "",
        content: "",
        subject_id: "",
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
    onSubmit() {
      // this.data.subject_id = this.selectedOption.value;
      // this.$api.contact.createNewContact(this.data).then((res) => {
      //   alert("Create new contact successfully");
      //   this.$router.push("/mentor");
      // });
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
