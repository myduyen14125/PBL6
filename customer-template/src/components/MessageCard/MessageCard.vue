<template>
  <div class="w-400 message-card py-2 px-3 border-bottom">
    <div class="row pb-2">
      <div class="col-2">
        <img
          :src="avatar"
          class="rounded-circle"
          alt="Mentor avatar"
          width="40"
          height="40"
        />
      </div>
      <div class="col-7">
        <p class="mb-0 fw-400"><strong>Trần Thị Ngà</strong></p>
        <p class="message-content fw-400">
          Với sứ mệnh là nâng cao chất lượng nguồn nhân lực, giúp thanh niên
          Việt Nam định vị nghề nghiệp và tạo cơ hội phát triển. Với sứ mệnh là
          nâng cao chất lượng nguồn nhân lực, giúp thanh niên Việt Nam định vị
          nghề nghiệp và tạo cơ hội phát triển
        </p>
      </div>
      <div class="col-3 fw-400 fs-11">7 ngày trước</div>
    </div>
  </div>
</template>

<script lang="ts" src="./MessageCard.ts"></script>
<style scoped lang="css" src="./style.css"></style>
