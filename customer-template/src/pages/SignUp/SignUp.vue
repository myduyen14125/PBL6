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
          <div>
            <div class="btn-sign-in mb-3 mx-4">
              <img :src="facebookLogo" alt="Logo" width="30" height="30" />
              <span>Đăng nhập bằng Facebook</span>
            </div>
            <div class="btn-sign-in mx-4">
              <img :src="gmailLogo" alt="Logo" width="30" height="30" />
              <span> Đăng nhập bằng Gmail</span>
            </div>
          </div>
          <p class="text-center my-4 fw-100">Hoặc</p>
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
            <div className="form-group required mb-3">
              <label>Họ và tên</label>
              <input
                type="text"
                v-model="form.name"
                name="name"
                :className="
                  ['form-control', error.name ? 'is-invalid' : '']
                    .filter(Boolean)
                    .join(' ')
                "
                placeholder="Nhập họ và tên"
                @blur="validateRequired('name')"
              />
              <p v-if="error.name" class="error-message mt-1">
                {{ error.name }}
              </p>
            </div>
            <div className="form-group required mb-3">
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
            <div className="form-group required mb-3">
              <label>Nhập lại mật khẩu</label>
              <input
                type="password"
                v-model="form.confirmPassword"
                name="confirmPassword"
                :className="
                  ['form-control', error.confirmPassword ? 'is-invalid' : '']
                    .filter(Boolean)
                    .join(' ')
                "
                placeholder="Nhập lại mật khẩu"
                @blur="validateConfirmPassword"
              />
              <p v-if="error.confirmPassword" class="error-message mt-1">
                {{ error.confirmPassword }}
              </p>
            </div>
            <div className="form-group mb-3">
              <label>Giới tính</label>
              <el-select
                name="gender"
                v-model="form.gender"
                class="w-100"
                placeholder="Chọn giới tính"
              >
                <el-option label="Nam" :value="false" />
                <el-option label="Nữ" :value="true" />
              </el-select>
            </div>
            <div className="form-group mb-3">
              <label>Ngày sinh</label>
              <el-date-picker
                name="birthday"
                v-model="form.birthday"
                type="date"
                placeholder="DD/MM/YYYY"
                format="DD/MM/YYYY"
                value-format="DD/MM/YYYY"
                class="w-100"
              >
                <template #default="cell">
                  <div class="cell" :class="{ current: cell.isCurrent }">
                    <span class="text">{{ cell.text }}</span>
                  </div>
                </template>
              </el-date-picker>
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
                Đăng ký
              </button>
            </div>
            <div>
              <span
                >Bạn đã có tài khoản?
                <router-link class="link" to="/sign-in"
                  >Hãy click vào đây để đăng nhập</router-link
                >
              </span>
            </div>
          </form>
        </div>
      </div>
    </div>
  </GuestLayout>
</template>

<script lang="ts" src="./SignUp.ts"></script>
<style scoped lang="css" src="./style.css"></style>
