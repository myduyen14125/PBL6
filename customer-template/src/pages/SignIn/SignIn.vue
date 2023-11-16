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
            <div className="form-group required mb-3">
              <label>Email</label>
              <input
                type="text"
                v-model="form.email"
                name="email"
                :className="
                  ['form-control', error.email ? 'is-invalid' : '']
                    .filter(Boolean)
                    .join(' ')
                "
                placeholder="Nhập email"
                @blur="validateRequired('email')"
              />
              <p v-if="error.email" class="error-message mt-1">
                {{ error.email }}
              </p>
            </div>
            <div className="form-group required">
              <label>Mật khẩu</label>
              <input
                type="password"
                v-model="form.password"
                name="password"
                :className="
                  ['form-control', error.password ? 'is-invalid' : '']
                    .filter(Boolean)
                    .join(' ')
                "
                placeholder="Nhập mật khẩu"
                @blur="validateRequired('password')"
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
                className="btn btn-primary px-4"
                type="submit"
                :disabled="isSubmitting"
              >
                <span
                  v-if="isSubmitting"
                  className="spinner-border spinner-border-sm mr-2"
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
