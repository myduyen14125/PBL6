<template>
  <div class="d-flex align-items-center justify-content-center py-5">
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
        <form class="mt-4" @submit="submitForm">
          <div className="form-group mb-3">
            <label>Email:</label>
            <input
              v-model="form.email"
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
          <div className="form-group">
            <label>Mật khẩu:</label>
            <input
              v-model="form.password"
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
          <div class="text-end">
            <a class="link" href="#">Quên mật khẩu</a>
          </div>
          <div class="d-flex align-items-center justify-content-center my-3">
            <button className="btn btn-primary px-4" type="submit">
              Đăng nhập
            </button>
          </div>
          <div>
            <span
              >Bạn chưa có tài khoản?
              <a class="link" href="#">Hãy click vào đây để đăng ký</a>
            </span>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script lang="ts" src="./SignIn.ts"></script>
<style scoped lang="css" src="./style.css"></style>
