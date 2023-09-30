<template>
  <div class="overflow-auto h-90">
    <ValidationObserver ref="form">
      <form
        class="form-wrapper mx-auto h-100"
        method="POST"
        @submit.prevent="onSubmit()"
      >
        <div class="d-flex">
          <div class="col-lg-12 px-0">
            <div class="form-group color-primary">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|max:200"
                name="title"
              >
                <label for="name">
                  Job title
                  <span class="text-danger __label">*</span>
                </label>
                <input
                  v-model="data.title"
                  type="text"
                  class="form-control color-secondary"
                  name="name"
                  placeholder="Enter job title"
                  @blur="trimInput(data, 'title')"
                />
                <span v-if="errors[0]" class="text-danger __label validate-text">{{
                  errors[0]
                }}</span>
              </ValidationProvider>
            </div>
            <div class="form-group color-primary mt-4">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required"
                name="working type"
              >
                <label>
                  Working type
                  <span class="text-danger __label">*</span>
                </label>
                <v-select
                  v-model="selectedOption"
                  class="style-chooser"
                  placeholder="Choose working type"
                  :options="options"
                  :value="job.working_type"
                />
                <span v-if="errors[0]" class="text-danger __label validate-text">{{
                  errors[0]
                }}</span>
              </ValidationProvider>
            </div>
            <div class="form-group color-primary mt-4">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|max:200"
                name="address"
              >
                <label for="content">
                  Address
                  <span class="text-danger __label">*</span>
                </label>
                <input
                  v-model="data.address"
                  class="form-control color-secondary"
                  name="message"
                  rows="4"
                  placeholder="Enter job address"
                  @blur="trimInput(data, 'address')"
                />
                <span v-if="errors[0]" class="text-danger __label validate-text">{{
                  errors[0]
                }}</span>
              </ValidationProvider>
            </div>
            <div class="form-group color-primary mt-4">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|numeric|max_value:1000000000"
                name="salary"
              >
                <label for="content">
                  Salary
                  <span class="text-danger __label">*</span>
                </label>
                <input
                  v-model="data.salary"
                  class="form-control color-secondary"
                  name="message"
                  rows="4"
                  placeholder="Enter job salary"
                  @input="onInputNumber"
                />
                <span v-if="errors[0]" class="text-danger __label validate-text">{{
                  errors[0]
                }}</span>
              </ValidationProvider>
            </div>
            <div class="form-group color-primary mt-4">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|max:2000"
                name="introduction"
              >
                <label for="content">
                  Introduction
                  <span class="text-danger __label">*</span>
                </label>
                <textarea
                  v-model="data.introduction"
                  class="form-control color-secondary"
                  name="message"
                  rows="4"
                  placeholder="Enter job introduction"
                  @blur="trimInput(data, 'introduction')"
                ></textarea>
                <span v-if="errors[0]" class="text-danger __label validate-text">{{
                  errors[0]
                }}</span>
              </ValidationProvider>
            </div>
            <div class="form-group color-primary mt-4">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|date_format:yyyy-MM-dd"
                name="deadline"
              >
                <label for="content">
                  Deadline
                  <span class="text-danger __label">*</span>
                </label>
                <!-- <input
                  v-model="data.deadline"
                  type="date"
                  :min="minDate"
                  maxlength="10"
                  class="form-control color-secondary date-picker"
                  placeholder="Enter job dealine"
                  @keydown.prevent
                  @paste.prevent
                  @cut.prevent
                /> -->
                <DatePicker v-model="data.deadline" :disabled-dates="disabledDates" placeholder="Select job deadline" format="dd-MM-yyyy" class="datepicker"></DatePicker>
                <span v-if="errors[0]" class="text-danger __label validate-text">{{
                  errors[0] 
                }}</span>
              </ValidationProvider>
            </div>
            <div class="form-group color-primary mt-4">
              <label for="content">
                Responsibilities
                <span class="text-danger __label">*</span>
              </label>
              <div
                v-for="index in countResponsibility"
                :key="index"
                class="d-flex position-relative fit-content"
              >
                <ValidationProvider
                  v-slot="{ errors }"
                  rules="required|max:500"
                  name="responsibilities"
                >
                  <input
                    v-if="data.responsibilities"
                    v-model="data.responsibilities[index - 1]"
                    class="form-control color-secondary mt-2 pr-3-rem"
                    placeholder="Enter job responsibility"
                    @keydown.enter.prevent="addMoreItem('responsibility')"
                    @blur="trimInputArray(data, 'responsibilities')"
                  />
                  <span v-if="errors[0]" class="text-danger __label validate-text">{{
                    errors[0]
                  }}</span>
                </ValidationProvider>

                <font-awesome-icon
                  class="remove-icon"
                  icon="fa-solid fa-trash"
                  @click="removeItem('responsibility', index - 1)"
                />
              </div>
              <button
                class="btn-add mt-2"
                @click.prevent="addMoreItem('responsibility')"
              >
                Add more
              </button>
            </div>
            <div class="form-group color-primary mt-4">
              <label for="content">
                Requirements
                <span class="text-danger __label">*</span>
              </label>
              <div
                v-for="index in countRequirement"
                :key="index"
                class="d-flex position-relative fit-content"
              >
                <ValidationProvider
                  v-slot="{ errors }"
                  rules="required|max:500"
                  name="requirements"
                >
                  <input
                    v-if="data.requirements"
                    v-model="data.requirements[index - 1]"
                    class="form-control color-secondary mt-2 pr-3-rem"
                    placeholder="Enter job requirement"
                    @keydown.enter.prevent="addMoreItem('requirement')"
                    @blur="trimInputArray(data, 'requirements')"
                  />
                  <span v-if="errors[0]" class="text-danger __label validate-text">{{
                    errors[0]
                  }}</span>
                </ValidationProvider>

                <font-awesome-icon
                  class="remove-icon"
                  icon="fa-solid fa-trash"
                  @click="removeItem('requirement', index - 1)"
                />
              </div>
              <button
                class="btn-add mt-2"
                @click.prevent="addMoreItem('requirement')"
              >
                Add more
              </button>
            </div>
            <div class="form-group color-primary mt-4">
              <label for="content">
                Benefits
                <span class="text-danger __label">*</span>
              </label>
              <div
                v-for="index of countBenefit"
                :key="index"
                class="d-flex position-relative fit-content"
              >
                <ValidationProvider
                  v-slot="{ errors }"
                  rules="required|max:500"
                  name="benefits"
                >
                  <input
                    v-if="data.benefits"
                    v-model="data.benefits[index - 1]"
                    class="form-control color-secondary mt-2 pr-3-rem"
                    placeholder="Enter job benefit"
                    @keydown.enter.prevent="addMoreItem('benefit')"
                    @blur="trimInputArray(data, 'benefits')"
                  />
                  <span v-if="errors[0]" class="text-danger __label validate-text">{{
                    errors[0]
                  }}</span>
                </ValidationProvider>
                <font-awesome-icon
                  class="remove-icon"
                  icon="fa-solid fa-trash"
                  @click="removeItem('benefit', index - 1)"
                />
              </div>
              <button
                class="btn-add mt-2"
                @click.prevent="addMoreItem('benefit')"
              >
                Add more
              </button>
            </div>
            <!-- Button submit -->
            <div class="form-group mt-4">
              <button type="submit" class="btn-custom btn-blue">
                {{ job.id ? 'Update' : 'Create' }}
              </button>
            </div>
          </div>
        </div>
      </form>
    </ValidationObserver>
  </div>
</template>
<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import moment from 'moment'
import DatePicker from '@sum.cumo/vue-datepicker'
import '@sum.cumo/vue-datepicker/dist/Datepicker.css'

export default {
  name: 'FormContact',
  components: {
    ValidationObserver,
    ValidationProvider,
    DatePicker,
  },
  props: {
    job: {
      type: Object,
      default: () => ({}),
    },
  },
  data() {
    return {
      responsibilities: this.job.responsibilities,
      requirements: this.job.requirements,
      benefits: this.job.benefits,
      options: [
        { value: 'FULL_TIME', label: 'Full Time' },
        { value: 'PART_TIME', label: 'Part Time' },
      ],
      messages: {
        date_format: 'Please enter a valid date format: dd-mm-yyyy',
      },
    }
  },
  computed: {
    data() {
      return this.job
    },
    deadline() {
      return moment(this.data.deadline).format('YYYY-MM-DD')
    },
    disabledDates() {
      const yesterday = new Date();
      yesterday.setDate(yesterday.getDate() - 1);
      return {
        to: yesterday,
      };
    },
    countResponsibility() {
      return this.job.responsibilities && this.job.responsibilities.length > 0
        ? this.job.responsibilities.length
        : 1
    },
    countRequirement() {
      return this.job.requirements && this.job.requirements.length > 0
        ? this.job.requirements.length
        : 1
    },
    countBenefit() {
      return this.job.benefits && this.job.benefits.length > 0
        ? this.job.benefits.length
        : 1
    },
    selectedOption: {
      get() {
        return this.options.find(
          (item) => item.value === this.data.working_type
        )
      },
      set(value) {
        this.data.working_type = value.value
      },
    },
  },
  watch: {
    deadline() {
      this.data.deadline = this.deadline
    },
  },
  mounted() {
    console.log(
      'count: ',
      this.countResponsibility +
        ' ' +
        this.countRequirement +
        ' ' +
        this.countBenefit
    )
  },
  methods: {
    async onSubmit() {
      try {
        await this.$refs.form.validate().then((success) => {
          if (success) {
            this.data.working_type = this.selectedOption.value
            this.$emit('submit', this.job)
          }
          else {
            // scroll to first error
            const error = document.querySelector('.validate-text')
            error.scrollIntoView({ behavior: 'smooth', block: 'center' })     
          }
        })
      } catch (error) {
        // Display all errors in the UI and scroll to the first error
        Object.values(this.$refs).forEach((ref) => {
          if (ref.errors) {
            ref.errors.forEach((error) => {
              ref.setError(error)
            })
          }
        })
        
      }
    },
    addMoreItem(item) {
      if (item === 'responsibility') {
        this.countResponsibility++
        this.data.responsibilities.push('')
      }
      if (item === 'requirement') {
        this.countRequirement++
        this.data.requirements.push('')
      }
      if (item === 'benefit') {
        this.countBenefit++
        this.data.benefits.push('')
      }
    },
    removeItem(item, index) {
      if (item === 'responsibility') {
        this.countResponsibility--
        this.data.responsibilities.splice(index, 1)
      }
      if (item === 'requirement') {
        this.countRequirement--
        this.data.requirements.splice(index, 1)
      }
      if (item === 'benefit') {
        this.countBenefit--
        this.data.benefits.splice(index, 1)
      }
    },
    onInputNumber(event) {
      // Remove any non-numeric characters from the input value
      this.data.salary = event.target.value.replace(/[^\d]/g, '');
    },
  },
}
</script>
<style lang="scss" scoped>
@import "@/assets/scss/toggle.scss";
.pr-3-rem {
  padding-right: 3rem;
}
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
.remove-icon {
  position: absolute;
  right: 16px;
  top: 20px;
  color: $color-secondary;
  font-size: 20px;
  cursor: pointer;
  &:hover {
    color: $color-primary;
  }
}
</style>