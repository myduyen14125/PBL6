<template>
  <div class="overflow-auto h-90">
    <ValidationObserver ref="form">
      <div class="form-wrapper mx-auto h-100">
        <div class="d-flex">
          <div class="col-lg-12 px-0">
            <div class="form-group color-primary">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|max:200"
                name="title"
              >
                <label for="name">
                  Title
                  <span class="text-danger __label">*</span>
                </label>
                <input
                  v-model="data.title"
                  type="text"
                  class="form-control color-secondary"
                  name="name"
                  placeholder="Enter title name"
                  required
                />
                <span class="text-danger __label validate-text">{{ errors[0] }}</span>
              </ValidationProvider>
            </div>
            <!-- Button submit :class="{ 'btn-disabled': isFormInvalid }" 
                :disabled="isFormInvalid"-->
            <div class="form-group mt-4">
              <button
                type="submit"
                class="btn-custom btn-blue"
                @click.prevent="onSubmit()"
              >
                {{ buttonContent }}
              </button>
            </div>
          </div>

        </div>
      </div>
    </ValidationObserver>
    
  </div>
</template>
<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate';

export default {
  components: {
    ValidationObserver,
    ValidationProvider,
  },
  props: {
    subdata: {
      type: Object,
      default: () => ({})
    },
    buttonContent: {
      type: String,
      default: () => 'Submit form'
    }
  },
  data() {
    return {
    }
  },
  computed: {
    data() {
      return this.subdata
    },
    // isFormInvalid() {
    //   return !this.data.title || this.data.title.length > 200
    // },
  },
  mounted() {
  },
  methods: {
    onSubmit() {
      try {
        // if has error from this.$refs.form.validate(), it will return false
        this.$refs.form.validate().then((success) => {
          if (success) {
            this.$emit('submit', this.data)
          }
        })
        
      } catch (error) {
        console.log(error)
      }
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
    width: 780px;
    &::placeholder {
      color: $color-secondary;
    }
  }
  textarea {
    width: 780px;
    &::placeholder {
      color: $color-secondary;
    }
  }
}
</style>