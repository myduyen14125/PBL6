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
          <div class="text-center my-4 fw-100" style="opacity: 0.7">
            <p>Nhập email tài khoản bạn đăng nhập trên IT Mentor.</p>
            <p>Chúng tôi sẽ gửi lại mật khẩu vào email cho bạn.</p>
          </div>
          <div className="form-group required mb-3">
            <label>Email</label>
            <input
              required
              type="email"
              v-model="form.email"
              name="email"
              :className="
                ['form-control', error.email ? 'is-invalid' : '']
                  .filter(Boolean)
                  .join(' ')
              "
              placeholder="Nhập email của bạn"
            />
          </div>
          <div class="d-flex align-items-center justify-content-center my-4">
            <button
              className="btn btn-primary px-4"
              type="submit"
              @click="getPassword"
            >
              Lấy lại mật khẩu
              <span
                v-if="isSubmitting"
                className="spinner-border spinner-border-sm ms-2"
                role="status"
                aria-hidden="true"
              ></span>
            </button>
          </div>
          <div class="d-flex align-items-center justify-content-center my-4">
            <span>
              <router-link class="link" to="/sign-in"
                >Quay lại đăng nhập</router-link
              >
            </span>
          </div>
        </div>
      </div>
    </div>
  </GuestLayout>
</template>

<script lang="ts" src="./ForgetPassword"></script>
