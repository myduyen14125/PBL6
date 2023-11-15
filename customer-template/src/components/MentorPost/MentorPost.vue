<template>
  <div class="mentor-post border-bottom">
    <div class="row pb-4">
      <div
        class="col-12 col-sm-4 mt-3"
        @click="() => router.push(`/blogs/${blog._id}`)"
      >
        <div class="post-img d-flex justify-content-center w-100">
          <img :src="blog?.avatar || postImg" alt="Post" />
        </div>
      </div>
      <div
        :class="`col-12 col-sm-6 p-4 p-sm-3 ${
          showEdit ? 'col-sm-6' : 'col-sm-8'
        }`"
        @click="() => router.push(`/blogs/${blog._id}`)"
      >
        <div class="title-action">
          <h4 class="text-uppercase">{{ blog?.title || "" }}</h4>
          <div
            v-if="getUserInfo()?._id == blog.user"
            class="d-flex align-items-center justify-content-end"
          >
            <el-tooltip
              class="box-item"
              effect="light"
              content="Chỉnh sửa"
              placement="bottom"
            >
              <SvgIcon icon="edit" class="p-2 mr-2 bg-edit button" />
            </el-tooltip>
            <el-tooltip
              class="box-item"
              effect="light"
              content="Xóa"
              placement="bottom"
            >
              <SvgIcon icon="delete" class="p-2 bg-delete button" />
            </el-tooltip>
          </div>
        </div>
        <div class="px-3 d-flex align-items-center mentor-info my-4">
          <img
            :src="blog?.user?.avatar || avatar"
            alt="Mentor avatar"
            class="rounded-circle w-[50px] h-[50px]"
          />
          <span class="color-primary mx-3">{{ blog?.user?.name || "" }}</span>
          <SvgIcon icon="birthdayIcon" />
          <span class="color-primary ml-2">{{
            formatDate(blog?.createdAt, "DD/MM/YYYY") || ""
          }}</span>
        </div>
        <div>
          <span v-if="blog?.content" v-html="demoContent"></span>
        </div>
      </div>
      <div :class="`col-12 ${showEdit ? 'col-sm-2' : 'hidden'}`">
        <div
          v-if="showEdit"
          class="d-flex flex-wrap align-items-center justify-content-end"
        >
          <el-tooltip
            class="box-item"
            effect="light"
            content="Chỉnh sửa"
            placement="bottom"
          >
            <SvgIcon
              icon="edit"
              class="p-2 m-1 bg-edit button"
              @click="editBlog"
            />
          </el-tooltip>
          <el-tooltip
            class="box-item"
            effect="light"
            content="Xóa"
            placement="bottom"
          >
            <SvgIcon
              icon="delete"
              class="p-2 m-1 bg-delete button"
              @click="deleteBlog"
            />
          </el-tooltip>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" src="./MentorPost.ts"></script>
<style scoped lang="css" src="./style.css"></style>
