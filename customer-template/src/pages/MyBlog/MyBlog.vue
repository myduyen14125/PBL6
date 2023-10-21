<template>
  <GuestLayout>
    <div class="blogs-page">
      <div class="container">
        <div class="row mt-5">
          <div class="page-title">
            <h2 class="pb-2">My Blogs</h2>
            <a href="/create-blog"
              class="create-button btn btn-primary px-4 action-button my-2"
            >
              Tạo bài viết
            </a>
          </div>
        </div>

        <div class="row">
          <div
            v-if="isLoadingBlog"
            class="col-12 d-flex align-items-center justify-content-center"
          >
            <div class="spinner-border text-info" role="status"></div>
          </div>
          <div v-else v-for="blog in blogs" :key="blog?._id">
            <MentorPost :blog="blog" />
          </div>
        </div>
      </div>
    </div>
  </GuestLayout>
</template>
<script lang="ts" src="./MyBlog.ts"></script>
<style scoped lang="css" src="./style.css"></style>
