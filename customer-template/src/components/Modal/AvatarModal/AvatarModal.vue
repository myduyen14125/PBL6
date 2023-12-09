<template>
  <BModal
    v-model:modal="modal"
    id="avatar_modal"
    title="Cập nhật ảnh bìa"
    size="lg"
    animation="fade"
    :noCloseOnBackdrop="true"
  >
    <template v-slot:body>
      <div class="d-flex justify-content-center">
        <img :src="avatar || ''" alt="avatar" ref="avatarSrc" />
      </div>
    </template>
    <template v-slot:footer>
      <button
        className="btn btn-primary px-4 action-button"
        @click="updateAvatar"
      >
        Lưu thay đổi
      </button>
    </template>
  </BModal>
</template>
<script lang="ts" src="./AvatarModal.ts"></script>
<style scoped lang="css" src="./style.css"></style>
