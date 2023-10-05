<template>
  <div class="mentor-post">
    <div class="row border-bottom pb-4">
      <div class="col-12 col-sm-4 mt-3">
        <div
          class="post-img d-flex align-items-center justify-content-center w-100"
        >
          <img :src="postImg" alt="Post" />
        </div>
      </div>
      <div class="col-12 col-sm-8 p-3">
        <h4>TỔNG QUAN VỀ NGÀNH TÀI CHÍNH (FUNCTION AND INDUSTRY)</h4>
        <div class="px-3 d-flex align-items-center mentor-info my-4">
          <img
            :src="avatar"
            alt="Mentor avatar"
            width="50"
            height="50"
            class="rounded-circle"
          />
          <span class="color-primary mx-3">Trần Thị Ngà</span>
          <SvgIcon icon="birthdayIcon" />
          <span class="color-primary ml-2">17/08/2002</span>
        </div>
        <div>
          <span>Bài viết gồm 3 phần chính:</span><br />
          <span>
            1 - Mô hình kinh doanh, 2 - Các loại bảo hiểm, 3 - Cơ hội nghề
            nghiệp
          </span>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" src="./MentorPost.ts"></script>
<style scoped lang="css" src="./style.css"></style>
