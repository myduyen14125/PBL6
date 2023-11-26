<template>
  <GuestLayout>
    <div
      class="d-flex align-items-center justify-content-center py-5 form-container"
    >
      <div class="card">
        <div class="d-flex align-items-center justify-content-center">
          <img :src="logo" alt="Logo" width="180" height="180" />
        </div>
        <div class="card-body">
          <form @submit="submitForm">
            <div class="form-group required mb-3">
              <label>Email</label>
              <input
                type="email"
                v-model="form.email"
                name="email"
                :class="
                  ['form-control', error.email ? 'is-invalid' : '']
                    .filter(Boolean)
                    .join(' ')
                "
                placeholder="Nhập email"
                @blur="validateEmail()"
              />
              <p v-if="error.email" class="error-message mt-1">
                {{ error.email }}
              </p>
            </div>
            <div class="form-group required relative">
              <label>Mật khẩu</label>
              <input
                :type="isShowPassword ? 'text' : 'password'"
                v-model="form.password"
                name="password"
                :class="
                  ['form-control', error.password ? 'is-invalid' : '']
                    .filter(Boolean)
                    .join(' ')
                "
                placeholder="Nhập mật khẩu"
                @input="validatePassword()"
                @blur="validateRequired('password')"
              />
              <SvgIcon
                id="eye-icon"
                class="password-icon absolute right-8 top-[2.6rem] cursor-pointer"
                :icon="isShowPassword ? 'eye' : 'eyeSlash'"
                @click="isShowPassword = !isShowPassword"
              />
              <p v-if="error.password" class="error-message mt-1">
                {{ error.password }}
              </p>
            </div>
            <div class="text-end mt-3">
              <a class="link" href="/forget-password">Quên mật khẩu</a>
            </div>
            <div class="d-flex align-items-center justify-content-center my-4">
              <button
                class="btn btn-primary px-4"
                type="submit"
                :disabled="isSubmitting"
              >
                <span
                  v-if="isSubmitting"
                  class="spinner-border spinner-border-sm mr-2"
                  role="status"
                  aria-hidden="true"
                ></span>
                Đăng nhập
              </button>
            </div>
            <div>
              <span
                >Bạn chưa có tài khoản?
                <router-link class="link" to="/sign-up"
                  >Hãy click vào đây để đăng ký</router-link
                >
              </span>
            </div>
          </form>
        </div>
      </div>
    </div>
  </GuestLayout>
</template>

<script lang="ts" src="./SignIn.ts"></script>
<style scoped lang="css" src="./style.css"></style>
