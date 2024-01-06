<template>
  <div class="lesson-card border-bottom w-100">
    <div class="row pb-4">
      <div
        class="col-12 col-sm-4 mt-3"
        @click="() => router.push(`/lessons/${lesson._id}`)"
      >
        <div class="lesson-img d-flex justify-content-center w-100">
          <VideoPlayer
            :src="lesson?.video || undefined"
            controls
            :loop="false"
            :volume="0.6"
            style="width: 300px; height: 250px; object-fit: cover"
            alt="video"
          />
          <!-- <div v-else>
            <img
              :src="lesson?.image || avatar"
              style="width: 300px; height: 250px; object-fit: cover"
              alt="course image"
            />
          </div> -->
        </div>
      </div>
      <div
        :class="`col-12 col-sm-6 p-4 p-sm-3 ${
          showEdit ? 'col-sm-6' : 'col-sm-8'
        }`"
        @click="() => router.push(`/lessons/${lesson._id}`)"
      >
        <div class="title-action">
          <h4 class="text-uppercase">{{ lesson?.title || "" }}</h4>
          <div
            v-if="getUserInfo()?._id == lesson.user"
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
        <div class="px-3 d-flex align-items-center lesson-info my-4">
          <img
            :src="lesson?.image || avatar"
            alt="Mentor avatar"
            class="rounded-circle w-[50px] h-[50px]"
          />

          <span class="color-primary mx-3">{{ lesson?.user?.name || "" }}</span>
          <SvgIcon icon="birthdayIcon" />
          <span class="color-primary ml-2">{{
            formatDate(lesson?.createdAt, "DD/MM/YYYY") || ""
          }}</span>
        </div>
        <div>
          <span>{{ lesson?.description }}</span>
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
              @click="editLesson"
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
              @click="deleteLesson"
            />
          </el-tooltip>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" src="./LessonCard.ts"></script>
<style scoped lang="css" src="./style.css"></style>
