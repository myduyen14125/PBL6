<template>
  <GuestLayout>
    <div class="m-5 p-5 container">
      <div class="title mb-10">
        <h3>Tạo bài viết</h3>
      </div>
      <div>
        <h5 class="title">
          <input
            type="text"
            placeholder="Nhập tiêu đề"
            class="title-input"
            v-model="title"
          />
        </h5>
        <div class="content">
          <QuillEditor
            v-model:content="content"
            content-type="html"
            theme="snow"
            :toolbar="editorToolbar"
          />
        </div>
      </div>
      <div class="action">
        <button
          class="mt-4 btn btn-primary px-4 action-button my-2"
          type="submit"
          @click="submitContent"
        >
          Xong
        </button>
      </div>
    </div>
  </GuestLayout>
</template>
<script lang="ts" src="./CreateBlog.ts"></script>
<style scoped lang="css" src="./style.css"></style>
