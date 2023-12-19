<template>
  <div v-if="visible" class="modal-wrapper">
    <div class="modal-container w-screen py-7">
      <div class="modal-content">
        <h2 class="modal-title color-primary mb-4">Thêm chuyên môn</h2>
        <div>
          <ValidationObserver ref="form">
            <form
              class="form-wrapper"
              method="POST"
              @submit.prevent="onSubmit()"
            >
              <div class="form-group color-primary">
                <ValidationProvider
                  v-slot="{ errors }"
                  rules="required"
                  name="name"
                  ><label for="name">
                    Tên chuyên môn
                    <span class="text-danger __label">*</span>
                  </label>
                  <input
                    ref="nameInput"
                    v-model="expertise.name"
                    type="text"
                    class="form-control color-secondary w-100"
                    name="name"
                    placeholder="Nhập tên chuyên môn"
                  />
                  <span
                    v-if="errors[0]"
                    class="text-danger __label validate-text"
                    >{{ errors[0] }}</span
                  ></ValidationProvider
                >
              </div>
            </form>
          </ValidationObserver>
        </div>
        <div
          class="modal-buttons d-flex justify-content-center align-items-center w-100 mt-4"
        >
          <button class="btn-custom btn-white mr-3" @click="cancel">
            Cancel
          </button>
          <button class="btn-custom btn-blue" @click="onSubmit">Thêm</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ValidationObserver, ValidationProvider } from "vee-validate";

export default {
  components: { ValidationObserver, ValidationProvider },
  data() {
    return {
      visible: true,
      expertise: {
        name: "",
      },
    };
  },
  methods: {
    cancel() {
      this.visible = false;
      this.$emit("closeExpertise");
    },
    async onSubmit() {
      try {
        await this.$refs.form.validate().then((success) => {
          if (success) {
            this.addExpertise();
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
    addExpertise() {
      this.$api.contact
        .addExpertise(this.expertise)
        .then((res) => {
          this.$toast.success("Create succesfully!", {
            className: "my-toast",
          });
          this.$emit("loadExpertiseTable");

          this.cancel();
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

<style scoped lang="scss">
.modal-wrapper {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.6);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 100;
}

.modal-container {
  width: 500px;
  background-color: $color-white;
  border-radius: 16px;
  overflow: hidden;
}

.modal-content {
  padding: 40px 24px;
}

.modal-title {
  font-weight: 500;
  font-size: 24px;
}

.modal-description {
  font-weight: 400;
  font-size: 16px;
}

.btn-modal-function {
  background-color: $color-blue;
  color: $color-white;
  border: none;
  padding: 8px 12px;
  border-radius: 4px;
  cursor: pointer;
}
</style>
