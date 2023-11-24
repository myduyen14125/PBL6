<template>
  <div class="hidden lg:block">
    <SvgIcon icon="greenTriangle" class="absolute z-100" style="top: 500px; right: 400px;" />
    <img src="https://cdn.mentorcruise.com/img/home/shapes/green_triangle.svg" alt="Triangle" class="absolute"
      style="top: 500px; right: 400px; height: 70px; transform: rotate(20deg);">
  </div>
</template>
<script>
import { defineComponent, onMounted, ref } from "vue";
import SvgIcon from "@/components/BUI/SvgIcon/SvgIcon.vue";

export default defineComponent({
  name: "Home",
  components: { SvgIcon},
});
</script>