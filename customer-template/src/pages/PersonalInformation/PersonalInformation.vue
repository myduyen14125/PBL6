<template>
  <GuestLayout>
    <div class="m-5 p-5 container">
      <form @submit="submitUpdateForm">
        <div class="form-title mb-10"><h3>Thông tin cá nhân</h3></div>
        <div class="form-content">
          <div class="row">
            <div class="col-12 col-md-6">
              <p>
                <label for="email">Email:</label>
                <div class="input">{{ userInfo?.email || "" }}</div>
              </p>
              <p>
                <label for="name">Họ và tên:</label>
                <input class="input" type="text" id="name" name="name" required v-model="userInfo.name" />
              </p>
              <p>
                <label for="tel">Điện thoại:</label>
                <input class="input" type="text" id="tel" name="tel" />
              </p>
              <p>
                <label for="fb">Link Facebook:</label>
                <input class="input" type="text" id="fb" name="fb" />
              </p>
            </div>
            <div class="col-12 col-md-6">
              <p>
                <label for="address">Địa chỉ:</label>
                <input class="input" type="text" id="address" name="address" />
              </p>
              <p>
                <label for="birthday">Ngày sinh:</label>
                <input class="input" type="date" id="birthday" name="birthday" />
              </p>
              <p>
                <label for="gender">Giới tính:</label>
                <select class="input" name="gender" id="gender" v-model="userInfo.gender">
                  <option value="false">Nam</option>
                  <option value="true">Nữ</option>
                </select>
              </p>
              <p>
                <label for="skype">Link Skype:</label>
                <input class="input" type="text" id="skype" name="skype" />
              </p>
            </div>
          </div>
          <div class="row pt-4">
            <p>
              <strong>Lưu ý:</strong> IT Mentor sẽ liên lạc với bạn qua số <strong>Điện
              thoại</strong> trên khi gặp các trường hợp khẩn cấp trong quá trình bạn kết
              nối cố vấn. Ví dụ cố vấn/người nhận cố vấn quên xác nhận lịch hẹn
              hoặc không đến buổi hẹn...
            </p>
          </div>
        </div>
        <div class="form-action">
          <button class="mt-4 btn btn-primary px-4 action-button my-2" type="submit">Cập nhật</button>
        </div>
      </form>
    </div>
  </GuestLayout>
</template>

<script lang="ts" src="./PersonalInformation"></script>
<style scoped lang="css" src="./style.css"></style>
