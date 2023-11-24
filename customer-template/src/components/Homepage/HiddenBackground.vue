<template>
  <div class="hidden lg:block">
    <SvgIcon icon="greenTriangle" class="absolute z-100" style="top: 500px; right: 400px;" />
    <img src="https://cdn.mentorcruise.com/img/home/shapes/green_triangle.svg" alt="Triangle" class="absolute"
      style="top: 200px; left: 100px; height: 70px; transform: rotate(125deg);">
    <img src="https://cdn.mentorcruise.com/img/home/shapes/green_triangle.svg" alt="Triangle" class="absolute"
      style="top: 250px; right: 50px; height: 70px; transform: rotate(20deg);">
    <img src="https://cdn.mentorcruise.com/img/home/shapes/green_triangle.svg" alt="Triangle" class="absolute"
      style="top: 480px; left: 300px; height: 70px; transform: rotate(95deg);">
    <img src="https://cdn.mentorcruise.com/img/home/shapes/green_triangle.svg" alt="Triangle" class="absolute"
      style="top: 500px; right: 400px; height: 70px; transform: rotate(20deg);">
    <img src="https://cdn.mentorcruise.com/img/home/shapes/green_triangle.svg" alt="Triangle" class="absolute"
      style="top: 600px; right: 250px; height: 70px; transform: rotate(90deg);">
    <img src="https://cdn.mentorcruise.com/img/home/shapes/green_triangle.svg" alt="Triangle" class="absolute"
      style="top: 750px; left: 50px; height: 70px; transform: rotate(20deg);">

  </div>
</template>
<script>
import { defineComponent, onMounted, ref } from "vue";
import SvgIcon from "@/components/BUI/SvgIcon/SvgIcon.vue";

export default defineComponent({
  name: "Home",
  components: { SvgIcon },
});
</script>