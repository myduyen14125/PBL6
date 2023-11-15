<template>
  <div
    class="card-wrapper p-4 flex items-center shadow-md rounded-lg cursor-pointer hover:bg-gray-100"
  >
    <div class="card-image">
      <img :src="major.thumbnail" alt="Mentor avatar" />
    </div>
    <div class="card-content ml-4">
      <h5>{{ major.name }}</h5>
    </div>
  </div>
</template>

<script lang="ts" src="./MajorCard.ts"></script>
<style scoped lang="css" src="./style.css"></style>
