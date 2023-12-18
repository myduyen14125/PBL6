<template>
  <div class="overflow-auto h-90 px-5">
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
                  Title
                  <span class="text-danger __label">*</span>
                </label>
                <input
                  ref="titleInput"
                  v-model="data.title"
                  type="text"
                  class="form-control color-secondary w-100"
                  name="name"
                  placeholder="Enter blog title"
                />
                <span
                  v-if="errors[0]"
                  class="text-danger __label validate-text"
                  >{{ errors[0] }}</span
                >
              </ValidationProvider>
            </div>
            <div class="form-group color-primary">
              <ValidationProvider
                v-slot="{ errors }"
                rules="required|max:500"
                name="image"
              >
                <label for="link">
                  Image link
                  <span class="text-danger __label">*</span>
                </label>
                <input
                  ref="imageInput"
                  v-model="data.image"
                  type="text"
                  class="form-control color-secondary w-100"
                  name="link"
                  placeholder="Enter image link"
                />
                <span
                  v-if="errors[0]"
                  class="text-danger __label validate-text"
                  >{{ errors[0] }}</span
                >
              </ValidationProvider>
            </div>
            <div class="form-group color-primary mt-4">
              <label for="content">
                Content detail
                <span class="text-danger __label">*</span>
              </label>
              <AppEditor
                :content="data.content"
                @input="updateContent"
                @has-spaces="onHasSpaces"
              />
            </div>
            <!-- Button submit -->
            <div class="form-group mt-4">
              <button
                :disabled="hasErrors"
                type="submit"
                class="btn-custom btn-blue"
              >
                {{ blog._id ? "Update" : "Create" }}
              </button>
            </div>
          </div>
        </div>
      </form>
    </ValidationObserver>
  </div>
</template>
<script>
import { ValidationObserver, ValidationProvider } from "vee-validate";
import AppEditor from "@/components/uncommon/AppEditor.vue";

export default {
  components: {
    AppEditor,
    ValidationObserver,
    ValidationProvider,
  },
  props: {
    blog: {
      type: Object,
      default: null,
    },
  },
  data() {
    return {
      hasErrors: false,
      hasSpaces: false,
    };
  },
  computed: {
    data() {
      return (
        this.blog || {
          title: "",
          content: "",
          image: "",
        }
      );
    },
  },
  mounted() {
    this.hasSpaces = false;
  },
  methods: {
    async onSubmit() {
      try {
        await this.$refs.form.validate().then((success) => {
          if (success) {
            if (this.hasSpaces) {
              return;
            } else {
              this.$emit("submit", this.blog);
            }

            this.hasErrors = false;
          } else {
            const error = document.querySelector(".validate-text");
            error.scrollIntoView({ behavior: "smooth", block: "center" });
          }
        });
      } catch (error) {
        this.hasErrors = true;
        // Display all errors in the UI
        Object.values(this.$refs).forEach((ref) => {
          if (ref.errors) {
            ref.errors.forEach((error) => {
              console.log(error);
              ref.setError(error);
            });
          }
        });
      }
    },
    updateContent(value) {
      this.data.content = value;
    },

    onHasSpaces(hasSpaces) {
      this.hasSpaces = hasSpaces;
      console.log("hasSpaces: " + this.hasSpaces, "hasSpaceprop: " + hasSpaces);
    },
  },
};
</script>
<style lang="scss" scoped>
@import "@/assets/scss/toggle.scss";
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
.img {
  &-thumbnail {
    width: 263px;
    height: 200px;
    padding: 0;
  }
  &-detail {
    width: 780px;
    height: 248.38px;
    padding: 0;
  }
}
</style>
