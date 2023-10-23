<template>
  <GuestLayout>
    <div class="blogs-page">
      <div class="container">
        <div class="row mt-5 px-4">
          <div
            class="d-flex justify-content-between align-items-center border-bottom"
          >
            <h3 class="pb-3">Các bài viết của bạn</h3>
            <a
              href="/create-blog"
              class="btn btn-primary px-4 action-button my-2"
            >
              Tạo bài viết
            </a>
          </div>
        </div>
        <div class="row my-5 px-4">
          <div
            v-if="isLoadingBlog"
            class="col-12 d-flex align-items-center justify-content-center min-h-[250px]"
          >
            <div class="spinner-border text-info" role="status"></div>
          </div>
          <div v-else>
            <div v-for="blog in blogs" :key="blog?._id">
              <MentorPost
                :blog="blog"
                showEdit
                @deleteBlog="deleteBlog"
                @editBlog="editBlog"
              />
            </div>
            <div class="my-5 d-flex">
              <el-pagination
                class="ms-auto"
                v-model:current-page="currentPage"
                :page-size="limit"
                background
                layout="prev, pager, next"
                :total="totalElement"
                @current-change="getAllBlogsByMentorId"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  </GuestLayout>
</template>
<script lang="ts" src="./MyBlog.ts"></script>
<style scoped lang="css" src="./style.css"></style>
