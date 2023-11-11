<template>
  <BModal
    v-model:modal="modal"
    id="confirm_modal"
    title="Xác nhận"
    size="lg"
    animation="fade"
    :noCloseOnBackdrop="true"
  >
    <template v-slot:body>
      <div class="confirm_modal">
        <div
          v-if="getUserInfo().role == 'mentee'"
          class="flex align-items-center"
        >
          <p class="mr-3">Nhận cố vẫn từ:</p>
          <p>{{ appointment?.mentor.name || "" }}</p>
        </div>
        <div v-else class="flex align-items-center">
          <p class="mr-3">Mentee:</p>
          <p>{{ appointment?.mentee.name || "" }}</p>
        </div>
        <div class="flex align-items-center">
          <p class="mr-3">Chủ đề:</p>
          <p>Định hướng và chia sẻ kinh nghiệm nghề nghiệp</p>
        </div>
        <div class="flex align-items-center">
          <p class="mr-3">Thời gian:</p>
          <p class="font-bold m-0">
            {{
              `${formatDate(
                appointment?.schedule?.start_at.slice(0, -1),
                "HH:mm DD/MM/YYYY"
              )}`
            }}
          </p>
        </div>
        <div class="flex align-items-center">
          <p class="mr-3">Thời lượng:</p>
          <p>1 tiếng</p>
        </div>
        <div class="flex align-items-center">
          <p class="mr-3">Google Meet:</p>
          <p>https:fhdjfdhjfhdjfdhj</p>
        </div>
        <div class="flex align-items-center">
          <p class="mr-3">Lời nhắn:</p>
          <p>abc dsds jdshd</p>
        </div>
      </div>
    </template>
    <template v-slot:footer>
      <button className="btn btn-primary px-4 action-button" @click="hide">
        Đóng
      </button>
    </template>
  </BModal>
</template>
<script lang="ts" src="./ConfirmModal.ts"></script>
<style scoped lang="css" src="./style.css"></style>
