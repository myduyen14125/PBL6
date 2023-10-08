<template>
  <div>
    <form class="form-wrapper mx-auto" method="POST" @submit.prevent="onSubmit()">
      <div class="d-flex">
        <div class="col-lg-6">
          <div class="form-group color-primary">
            <label for="name">
              Name
              <span class="text-danger __label">*</span>
            </label>
            <input
              v-model="data.name"
              type="text"
              class="form-control color-secondary"
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
              class="form-control color-secondary"
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
              class="form-control color-secondary"
              name="message"
              rows="5"
              placeholder="Enter your message"
              required
            ></textarea>
          </div>
          <!-- Button submit -->
          <div class="form-group mt-4">
            <button
              type="submit"
              class="btn-custom btn-blue"
            >
              Submit form
            </button>
          </div>
        </div>

        <!-- Col right -->
        <div class="col-lg-6">
          <div class="form-group color-primary">
            <label for="email">
              Email
              <span class="text-danger __label">*</span>
            </label>
            <input
              v-model="data.email"
              type="email"
              class="form-control color-secondary"
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
              class="style-chooser"
              placeholder="Choose Subject"
              :options="options"
            />
          </div>
        </div>
      </div>
    </form>
  </div>
</template>
<script>
export default {
  name: 'FormContact',
  props: {
    submit: {
      type: Function,
      default: () => {},
    },
    subjects: {
      type: Array,
      default: () => [],
    },
  },
  data() {
    return {
      options: this.subjects.map((item) => ({
        value: item.id,
        label: item.title,
      })),
      selectedOption: {
        value: '',
        label: '',
      },
      data: {
        name: '',
        email: '',
        phone: '',
        content: '',
        subject_id: '',
      },
    }
  },
  mounted() {
  },
  methods: {
    onSubmit() {
      this.data.subject_id = this.selectedOption.value
      this.$api.contact.createNewContact(this.data)
      .then((res) => {
        alert('Create new contact successfully')
        this.$router.push('/mentor')
      })
    },
  },
}
</script>
<style lang="scss" scoped>
.form-group {
  label {
    font-size: 14px;
  }
  input {
    width: 292px;
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