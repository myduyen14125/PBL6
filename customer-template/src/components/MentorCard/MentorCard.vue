<template>
  <div>
    <div class="card w-100 mt-4">
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
  </div>
</template>

<script lang="ts" src="./MentorCard.ts"></script>
<style scoped lang="css" src="./style.css"></style>
