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
                type="email"
                v-model="form.email"
                name="email"
                :className="
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
            <div className="form-group required mb-3 relative">
              <label>Mật khẩu</label>
              <input
                :type="isShowPassword ? 'text' : 'password'"
                v-model="form.password"
                name="password"
                :className="
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
            <div className="form-group required mb-3">
              <label>Giới tính</label>
              <el-select
                id="select-gender-signup"
                name="gender"
                v-model="form.gender"
                class="w-100"
                placeholder="Chọn giới tính"
              >
                <el-option id="select-gender-signup-male" label="Nam" :value="false" />
                <el-option id="select-gender-signup-female" label="Nữ" :value="true" />
              </el-select>
              <p v-if="error.gender" class="error-message mt-1">
                {{ error.gender }}
              </p>
            </div>
            <div className="form-group required mb-3">
              <label>Ngày sinh</label>
              <el-date-picker
                id="date-picker-signup"
                name="date_of_birth"
                v-model="form.date_of_birth"
                type="date"
                placeholder="DD/MM/YYYY"
                format="DD/MM/YYYY"
                value-format="YYYY-MM-DD"
                class="w-100"
                @change="validateDateOfBirth()"
              >
                <template #default="cell">
                  <div class="cell" :class="{ current: cell.isCurrent }">
                    <span class="text">{{ cell.text }}</span>
                  </div>
                </template>
              </el-date-picker>
              <p v-if="error.date_of_birth" class="error-message mt-1">
                {{ error.date_of_birth }}
              </p>
            </div>
            <div className="form-group required mb-3">
              <label>Bạn muốn đăng kí với vai trò</label>
              <el-select
                id="select-role-signup"
                name="role"
                v-model="form.role"
                class="w-100"
                placeholder="Chọn vai trò"
              >
                <el-option id="select-role-signup-mentor" label="Mentor" value="mentor" />
                <el-option id="select-role-signup-mentee" label="Mentee" value="mentee" />
              </el-select>
              <p v-if="error.role" class="error-message mt-1">
                {{ error.role }}
              </p>
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
