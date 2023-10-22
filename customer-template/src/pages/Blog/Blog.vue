<template>
  <GuestLayout>
    <div class="blogs-page">
      <div class="container">
        <a href="#" target="_blank">
          <img class="wall-paper-img my-3 mt-lg-5" :src="wallPaper" />
        </a>
        <div class="row mt-5">
          <div class="col-lg-9">
            <h3 class="border-bottom pb-2">Tin tức nổi bật</h3>
            <div class="my-5">
              <div
                v-if="isLoadingBlogs"
                class="col-12 d-flex align-items-center justify-content-center"
              >
                <div class="spinner-border text-info" role="status"></div>
              </div>
              <div v-else>
                <div v-for="blog in blogs" :key="blog?._id">
                  <MentorPost :blog="blog" />
                </div>
                <div class="my-5 d-flex">
                  <el-pagination
                    class="ms-auto"
                    v-model:current-page="currentPage"
                    :page-size="limit"
                    background
                    layout="prev, pager, next"
                    :total="totalElement"
                    @current-change="getBlogs"
                  />
                </div>
              </div>
            </div>
          </div>
          <div class="col-lg-3">
            <div>
              <a href="#" target="_blank">
                <img
                  class="w-100 px-2"
                  :src="advertisementImg"
                  alt="Advertisement"
                />
              </a>
            </div>
            <div class="my-4">
              <h5>Tác giả nổi bật</h5>
              <div class="my-4">
                <div
                  v-for="mentor in mentors"
                  :key="mentor?._id"
                  class="d-flex my-3 cursor-pointer"
                  @click="() => router.push(`/user/${mentor?._id}`)"
                >
                  <img :src="avatar" class="avatar-img me-3" />
                  <div>
                    <p class="author mb-0">{{ mentor?.name || "" }}</p>
                    <p class="job mb-0">CEO tại Babylux Viet Nam</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </GuestLayout>
</template>
<script lang="ts" src="./Blog.ts"></script>
<style scoped lang="css" src="./style.css"></style>
