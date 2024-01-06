<template>
  <BModal
    v-model:modal="modal"
    id="confirm_modal"
    title="Thông tin cuộc hẹn"
    size="lg"
    animation="fade"
    :noCloseOnBackdrop="true"
  >
    <template v-slot:body>
      <div>
        <div class="flex w-4/5 mx-auto font-700">
          <div
            class="w-1/2 border border-[#0a5565] px-4 py-8 rounded-md text-[#0a5565] shadow-md mr-4"
          >
            <div class="mb-4">
              <img
                :src="
                  getUserInfo()?.role == 'mentee'
                    ? appointment?.mentor?.avatar || avatar
                    : appointment?.mentee?.avatar || avatar
                "
                class="w-40 h-40 rounded-full mx-auto object-cover"
              />
            </div>
            <p v-if="getUserInfo()?.role == 'mentee'" class="text-lg">
              <span class="font-bold block w-40">Tên mentor: </span>
              {{ appointment?.mentor?.name }}
            </p>
            <p v-if="getUserInfo()?.role == 'mentor'" class="text-lg">
              <span class="font-bold block w-40">Tên mentee: </span>
              {{ appointment?.mentee?.name }}
            </p>
            <p class="text-lg">
              <span class="font-bold block w-40">Lĩnh vực: </span>
              {{
                appointment?.mentor?.expertise
                  ? appointment?.mentor?.expertise?.name
                  : ""
              }}
            </p>
            <p class="text-lg">
              <span class="font-bold block w-40">Email liên lạc: </span>
              {{
                getUserInfo()?.role == "mentee"
                  ? appointment?.mentor?.email
                  : appointment?.mentee?.email
              }}
            </p>
            <p class="text-lg">
              <span class="font-bold block w-40">Số điện thoại: </span>
              {{
                getUserInfo()?.role == "mentee"
                  ? appointment?.mentor?.phone
                  : appointment?.mentee?.phone
              }}
            </p>
          </div>
          <div
            class="w-1/2 border border-[#0a5565] px-4 py-8 rounded-md text-[#0a5565] shadow-md ml-4"
          >
            <p class="text-lg">
              <span class="font-bold block w-40">Ngày hẹn: </span>
              {{
                `${formatDate(
                  appointment?.schedule?.start_at.slice(0, -1),
                  "DD/MM/YYYY"
                )}`
              }}
            </p>
            <p class="text-lg">
              <span class="font-bold block w-40">Thời gian hẹn: </span>
              {{
                `${formatDate(
                  appointment?.schedule?.start_at.slice(0, -1),
                  "HH:mm"
                )}`
              }}
            </p>
            <p class="text-lg">
              <span class="font-bold block w-40">Thời lượng: </span>
              1 tiếng
            </p>
            <p class="text-lg">
              <span class="font-bold block w-40">Hình thức kết nối: </span>
              <span class="text-[#139896]">Online</span>
            </p>
            <p class="text-lg">
              <span class="font-bold block w-40">Link meeting: </span>
              <span class="text-[#139896]">{{ appointment?.mentor?.skype_link }}</span>
            </p>
            <p class="text-lg">
              <span class="font-bold block w-40">Ghi chú: </span>
              {{ appointment?.note || "" }}
            </p>
          </div>
        </div>
      </div>
    </template>
    <template v-slot:footer>
      <button
        v-if="status"
        className="btn btn-primary px-4 action-button mr-4"
        @click="confirm"
      >
        {{ status == "cancel" ? "Hủy lịch hẹn" : "Xác nhận lịch hẹn" }}
      </button>
      <button className="btn btn-primary px-4 action-button" @click="hide">
        Đóng
      </button>
    </template>
  </BModal>
</template>
<script lang="ts" src="./ConfirmModal.ts"></script>
<style scoped lang="css" src="./style.css"></style>
