<template>
  <GuestLayout>
    <div class="container">
      <div class="m-5 p-5 personal-info-page">
        <form @submit="submitUpdateForm">
          <div class="form-title mb-10"><h3>Thông tin cá nhân</h3></div>
          <div class="form-content">
            <div class="row">
              <div class="col-12 col-lg-6">
                <div class="form-group mb-3">
                  <label for="email">Email:</label>
                  <div class="email">{{ userInfo?.email || "" }}</div>
                </div>
                <div class="form-group mb-3 required">
                  <label for="name">Họ và tên:</label>
                  <input
                    :className="
                      ['form-control', error.name ? 'is-invalid' : '']
                        .filter(Boolean)
                        .join(' ')
                    "
                    type="text"
                    id="name"
                    name="name"
                    required
                    v-model="userInfo.name"
                    @blur="validateName()"
                  />
                </div>
                <div class="form-group mb-3 required">
                  <label for="tel">Điện thoại:</label>
                  <input
                    :className="
                      ['form-control', error.phone ? 'is-invalid' : '']
                        .filter(Boolean)
                        .join(' ')
                    "
                    type="text"
                    id="tel"
                    name="tel"
                    v-model="userInfo.phone"
                    @blur="validatePhone()"
                  />
                </div>
                <div class="form-group mb-3">
                  <label for="fb">Link Facebook:</label>
                  <input
                    class="form-control"
                    type="text"
                    id="fb"
                    name="fb"
                    v-model="userInfo.facebook_link"
                    placeholder="Nhập link facebook"
                  />
                </div>
              </div>
              <div class="col-12 col-lg-6">
                <div class="form-group mb-3 h-[32px]">
                  <!-- <label for="address">Địa chỉ:</label>
                  <input
                    class="form-control"
                    type="text"
                    id="address"
                    name="address"
                    v-model="userInfo.address"
                    placeholder="Nhập địa chỉ"
                  /> -->
                </div>
                <div class="form-group mb-3">
                  <label for="date_of_birth">Ngày sinh:</label>
                  <el-date-picker
                    id="date_of_birth"
                    name="date_of_birth"
                    v-model="userInfo.date_of_birth"
                    type="date"
                    placeholder="DD/MM/YYYY"
                    format="DD/MM/YYYY"
                    value-format="YYYY-MM-DD"
                    class="w-50"
                  >
                    <template #default="cell">
                      <div class="cell" :class="{ current: cell.isCurrent }">
                        <span class="text">{{ cell.text }}</span>
                      </div>
                    </template>
                  </el-date-picker>
                </div>
                <div class="form-group mb-3">
                  <label for="gender">Giới tính:</label>
                  <el-select
                    class="w-50"
                    name="gender"
                    v-model="userInfo.gender"
                    placeholder="Chọn giới tính"
                  >
                    <el-option label="Nam" :value="false" />
                    <el-option label="Nữ" :value="true" />
                  </el-select>
                </div>
                <div class="form-group mb-3">
                  <label for="skype">Link Skype:</label>
                  <input
                    class="form-control"
                    type="text"
                    id="skype"
                    name="skype"
                    v-model="userInfo.skype_link"
                    placeholder="Nhập link skype"
                  />
                </div>
              </div>
            </div>
            <div class="row py-4">
              <p>
                <strong>Lưu ý:</strong> IT Mentor sẽ liên lạc với bạn qua số
                <strong>Điện thoại</strong> trên khi gặp các trường hợp khẩn cấp
                trong quá trình bạn kết nối cố vấn. Ví dụ cố vấn/người nhận cố
                vấn quên xác nhận lịch hẹn hoặc không đến buổi hẹn...
              </p>
            </div>
          </div>
          <div class="form-action">
            <button
              class="btn btn-primary px-4 action-button my-2"
              type="submit"
              @click="updateInfo"
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
        </form>
      </div>
    </div>
  </GuestLayout>
</template>

<script lang="ts" src="./PersonalInformation"></script>
<style scoped lang="css" src="./style.css"></style>
