<template>
  <div class="mentor-card tooltip-container">
    <div ref="hoverTooltip" class="card w-100 mt-4 hover-tooltip">
      <div class="d-flex align-items-center justify-content-center">
        <img
          :src="avatar"
          class="rounded-circle"
          alt="Mentor avatar"
          width="200"
          height="200"
        />
      </div>

      <div class="card-body">
        <h5 class="card-title text-center">Trần Thị Ngà</h5>
        <p class="card-text text-center">Sinh viên tại DUT University.</p>
        <div class="d-flex align-items-center justify-content-between mt-5">
          <div class="d-flex align-items-center">
            <img :src="icMentee" alt="Mentee" width="18" height="18" />
            <span class="ml-2">41 mentee</span>
          </div>
          <div class="d-flex align-items-center">
            <img :src="icFollowed" alt="Mentee" width="18" height="18" />
            <span class="ml-2">200</span>
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
          <p class="card-text">Trần Thị Ngà</p>
          <h5 class="card-title border-bottom pb-2">Chủ đề mentoring</h5>
          <ul class="pl-0">
            <li>
              <strong>Định hướng và chia sẻ kinh nghiệm nghề nghiệp:</strong>
              Research Consultant tại WorldQuant VRC
            </li>
            <li>
              <strong>Định hướng và chia sẻ kinh nghiệm nghề nghiệp:</strong>
              Research Consultant tại WorldQuant VRC
            </li>
            <li>
              <strong>Định hướng và chia sẻ kinh nghiệm nghề nghiệp:</strong>
              Research Consultant tại WorldQuant VRC
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
