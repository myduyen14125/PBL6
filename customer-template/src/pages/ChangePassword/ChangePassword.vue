<template>
  <GuestLayout>
    <div class="container w-50">
      <div class="m-5 p-5 change-password-page">
        <div class="form-title mb-10"><h3>Cập nhật mật khẩu</h3></div>
        <div class="form-content">
          <div class="form-group mb-3">
            <label for="old-pass">Mật khẩu cũ:</label>
            <input
              v-model="form.old_password"
              required
              class="form-control"
              type="password"
              name="old-pass"
              placeholder="Nhập mật khẩu cũ"
            />
          </div>
          <div class="form-group mb-3">
            <label for="new-pass">Mật khẩu mới:</label>
            <input
              v-model="form.new_password"
              required
              class="form-control"
              type="password"
              name="new-pass"
              placeholder="Mật khẩu từ 6 đến 32 ký tự"
            />
          </div>
          <div class="form-group mb-3">
            <label for="re-pass">Nhập lại:</label>
            <input
              v-model="form.re_password"
              required
              class="form-control"
              type="password"
              name="re-pass"
              placeholder="Nhập lại mật khẩu mới"
            />
          </div>
        </div>
        <div class="form-action mt-4">
          <button
            class="btn btn-primary px-4 action-button my-2"
            type="submit"
            @click="changePassword"
          >
            Cập nhật
            <span
              v-if="isSubmitting"
              className="spinner-border spinner-border-sm ms-2"
              role="status"
              aria-hidden="true"
            ></span>
          </button>
        </div>
      </div>
    </div>
  </GuestLayout>
</template>

<script lang="ts" src="./ChangePassword"></script>
<style scoped lang="css" src="./style.css"></style>
