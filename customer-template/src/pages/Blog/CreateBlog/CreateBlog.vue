<template>
  <GuestLayout>
    <div class="container">
      <div class="m-5 p-5">
        <div class="mb-10">
          <h3 class="title">
            {{ id ? "Chỉnh sửa bài viết" : "Tạo bài viết" }}
          </h3>
        </div>
        <div>
          <div class="mb-4">
            <input
              type="text"
              placeholder="Nhập tiêu đề"
              :className="
                ['title-input', error.title ? 'is-invalid' : '']
                  .filter(Boolean)
                  .join(' ')
              "
              v-model="form.title"
              @blur="validateRequired('title')"
            />
            <p v-if="error.title" class="error-message mt-1">
              {{ error.title }}
            </p>
          </div>

          <div class="content">
            <QuillEditor
              ref="myEditor"
              v-model:content="form.content"
              content-type="html"
              theme="snow"
              :toolbar="editorToolbar"
              @blur="validateRequired('content')"
              placeholder="Nhập nội dung bài viết"
            />
            <p v-if="error.content" class="error-message mt-1">
              {{ error.content }}
            </p>
          </div>
        </div>
        <div class="action">
          <button
            class="mt-4 btn btn-primary px-4 action-button my-2 mr-3"
            type="submit"
            @click="showDemo"
          >
            Xem demo
          </button>
          <button
            class="mt-4 btn btn-primary px-4 action-button my-2"
            type="submit"
            @click="submitContent"
          >
            {{ id ? "Chỉnh sửa bài viết" : "Tạo bài viết" }}
            <span
              v-if="isSubmitting"
              className="spinner-border spinner-border-sm ms-2"
              role="status"
              aria-hidden="true"
            ></span>
          </button>
        </div>
      </div>
    </div>
  </GuestLayout>
  <DemoBlogModal ref="demoBlogModal" :blogDetail="form" />
</template>
<script lang="ts" src="./CreateBlog.ts"></script>
<style scoped lang="css" src="./style.css"></style>
