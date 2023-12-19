<template>
  <div
    data-testid="mentor-card"
    :class="{
      'mentor-card tooltip-container': hover,
      'mentor-card': !hover,
    }"
    
    ref="tooltipContainer"
    @click="() => router.push(`/user/${mentor._id}`)"
  >
    <div class="card w-100 mt-4 hover-tooltip">
      <div class="d-flex align-items-center justify-content-center">
        <img
          :src="handleImage(mentor.avatar)"
          class="rounded-circle object-cover w-48 h-48"
          alt="Mentor avatar"
        />
      </div>

      <div class="card-body">
        <h5 class="card-title text-center">{{ mentor.name }}</h5>
        <p class="card-text text-center">{{ mentor.description }}</p>
        <div class="d-flex align-items-center justify-content-between mt-5">
          <div class="d-flex align-items-center">
            <img :src="icMentee" alt="Mentee" width="18" height="18" />
            <span class="ml-2"
              >{{
                mentor.numberOfMentees ? mentor.numberOfMentees : 0
              }}
              mentees</span
            >
          </div>
          <div class="d-flex align-items-center">
            <img :src="icFollowed" alt="Mentee" width="18" height="18" />
            <span class="ml-2"
              >{{ mentor.numberOfLikes ? mentor.numberOfLikes : 0 }} likes</span
            >
          </div>
        </div>
      </div>
    </div>
    <div
      :class="{
        'mentor-card-info tooltip-mentor-card right': isTooltipRight,
        'mentor-card-info tooltip-mentor-card left': !isTooltipRight,
      }"
    >
      <div class="card w-100">
        <div class="card-body">
          <h5 class="card-title border-bottom pb-2">Giới thiệu bản thân</h5>
          <ul class="pl-0">
            <li>
              <strong>Tên mentor:</strong>
              {{ mentor.name }}
            </li>
            <li>
              <strong>Email:</strong>
              {{ mentor.email }}
            </li>
          </ul>
          <h5 class="card-title border-bottom pb-2">Chủ đề mentoring</h5>
          <ul class="pl-0">
            <li>
              <strong>Lĩnh vực:</strong>
              {{ mentor?.expertise?.name }}
            </li>
          </ul>
          <a
            class="d-block text-center color-primary text-decoration-none border-top pt-3"
            href="#"
            >Xem chi tiết</a
          >
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts" src="./MentorCard.ts"></script>
<style scoped lang="css" src="./style.css"></style>
