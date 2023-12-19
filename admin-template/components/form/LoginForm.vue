<template>
  <div class="form">
    <div class="title text-center mb-4">
      <h2>Login Account</h2>
    </div>
    <ValidationObserver ref="form">
      <form>
        <div class="form-group mb-4">
          <ValidationProvider
            v-slot="{ errors }"
            name="email"
            rules="required|email"
          >
            <label class="color-primary d-block">
              Email
              <span class="text-danger">*</span>
            </label>
            <input
              v-model="email"
              type="email"
              class="form-control"
              :class="{ 'is-invalid': errors[0] }"
              placeholder="Enter email"
              required
              @focus="isLoginError = true"
            />
            <div v-if="errors[0]" class="d-flex mt-1">
              <img
                src="@/assets/icons/warning-red.svg"
                alt="icon red"
                class="mr-1 mt-1"
              />
              <span class="text-danger __label validate-text">{{
                errors[0]
              }}</span>
            </div>
          </ValidationProvider>
        </div>
        <div class="form-group mb-4">
          <ValidationProvider
            v-slot="{ errors }"
            name="password"
            rules="required|min:8"
          >
            <label class="color-primary d-block">
              Password
              <span class="text-danger">*</span>
            </label>
            <div class="position-relative">
              <input
                v-model="password"
                :type="showPassword ? 'text' : 'password'"
                class="form-control pr-36px"
                :class="{ 'is-invalid': errors[0] }"
                placeholder="Enter password"
                required
                @focus="isLoginError = true"
              />
              <font-awesome-icon
                v-if="!showPassword && password && !errors[0]"
                class="icon-eye"
                icon="fa-solid fa-eye"
                @click="showPassword = !showPassword"
              />
              <font-awesome-icon
                v-if="showPassword && password && !errors[0]"
                class="icon-eye"
                icon="fa-solid fa-eye-slash"
                @click="showPassword = !showPassword"
              />
            </div>
            <div v-if="errors[0]" class="d-flex mt-1">
              <img
                src="@/assets/icons/warning-red.svg"
                alt="icon red"
                class="mr-1 mt-1"
              />
              <span class="text-danger __label validate-text">{{
                errors[0]
              }}</span>
            </div>
          </ValidationProvider>
          <div
            v-if="isLoginError === false"
            class="d-flex align-items-center mt-1"
          >
            <img
              src="@/assets/icons/warning-red.svg"
              alt="icon red"
              class="mr-1 mt-1"
            />
            <span class="text-danger __label validate-text">{{
              loginError
            }}</span>
          </div>
        </div>
        <div class="form-group">
          <input
            class="btn-custom btn-blue w-100"
            :class="{ 'btn-disabled': isFormInvalid }"
            type="submit"
            value="Login"
            :disabled="isFormInvalid"
            @click.prevent="handleLogin()"
          />
        </div>
      </form>
    </ValidationObserver>
  </div>
</template>

<script>
import { ValidationObserver, ValidationProvider } from "vee-validate";

export default {
  name: "LoginForm",
  components: {
    ValidationObserver,
    ValidationProvider,
  },
  data() {
    return {
      email: "",
      password: "",
      isLoginError: true,
      loginError: "",
      showPassword: false,
    };
  },
  computed: {
    isFormInvalid() {
      const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      const isEmailValid = emailPattern.test(this.email);
      const isPasswordValid = this.password.length >= 8;
      return !isEmailValid || !isPasswordValid;
    },
  },

  methods: {
    handleLogin() {
      try {
        this.$refs.form.validate();
        this.$auth
          .loginWith("local", {
            data: {
              email: this.email,
              password: this.password,
            },
          })
          .then((res) => {
            sessionStorage.setItem(
              "IT_MENTOR_accessToken",
              res?.data?.accessToken
            );
            this.$router.push("/mentor");
          })
          .catch((err) => {
            console.log("err", err.response?.data?.message);
            this.isLoginError = false;
            this.loginError = err.response?.data?.message
              ? err.response?.data?.message
              : "Sorry, an error has occurred. Please try again";
          });
      } catch (err) {
        this.isLoginError = false;
        this.loginError = "Sorry, an error has occurred. Please try again";
      }
    },
  },
};
</script>
<style lang="scss" scoped>
.form {
  height: auto;
}
h2 {
  font-size: 26px;
  font-weight: 600;
  line-height: 36px;
}
.btn-blue {
  &:hover {
    background-color: $color-primary;
    color: $color-white;
  }
}
.icon-eye {
  position: absolute;
  right: 12px;
  top: 50%;
  transform: translateY(-50%);
  cursor: pointer;
}
.pr-36px {
  padding-right: 36px;
}

.is-invalid {
  border-color: $color-red;
}
</style>
