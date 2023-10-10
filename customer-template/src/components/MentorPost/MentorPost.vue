<template>
  <div class="mentor-post">
    <div class="row border-bottom pb-4">
      <div class="col-12 col-sm-4 mt-3">
        <div
          class="post-img d-flex align-items-center justify-content-center w-100"
        >
          <img :src="blog?.avatar || postImg" alt="Post" />
        </div>
      </div>
      <div class="col-12 col-sm-8 p-3">
        <h4>{{ blog?.title || "" }}</h4>
        <div class="px-3 d-flex align-items-center mentor-info my-4">
          <img
            :src="blog?.user?.avatar || avatar"
            alt="Mentor avatar"
            width="50"
            height="50"
            class="rounded-circle"
          />
          <span class="color-primary mx-3">{{ blog?.user?.name || "" }}</span>
          <SvgIcon icon="birthdayIcon" />
          <span class="color-primary ml-2">{{
            formatDate(blog?.user?.date_of_birth, "DD/MM/YYYY") || ""
          }}</span>
        </div>
        <div>
          <span>
            {{ blog?.content || "" }}
          </span>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" src="./MentorPost.ts"></script>
<style scoped lang="css" src="./style.css"></style>
