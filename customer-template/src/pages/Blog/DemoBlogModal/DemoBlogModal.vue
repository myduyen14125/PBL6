<template>
  <BModal
    v-model:modal="modal"
    id="demo_blog_modal"
    title="Demo bài viết"
    size="lg"
    animation="fade"
    :noCloseOnBackdrop="true"
  >
    <template v-slot:body>
      <div class="demo-blog-modal">
        <div>
          <h3 class="text-uppercase fw-600">
            {{ blogDetail?.title || "" }}
          </h3>
          <div class="d-flex align-items-center py-3">
            <img
              :src="getUserInfo()?.avatar || avatar"
              class="avatar-img mx-3"
            />
            <div>
              <p class="author mb-0">
                {{ getUserInfo()?.name || "" }}
              </p>
              <p class="job mb-1">CEO tại Babylux Viet Nam</p>
              <p class="mb-0">
                {{ `Đăng ngày ${formatDate(new Date(), "DD/MM/YYYY") || ""}` }}
              </p>
            </div>
          </div>
          <div class="content py-3">
            <div v-if="blogDetail?.content" v-html="blogDetail?.content"></div>
          </div>
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
<script lang="ts" src="./DemoBlogModal.ts"></script>
<style scoped lang="css" src="./style.css"></style>
