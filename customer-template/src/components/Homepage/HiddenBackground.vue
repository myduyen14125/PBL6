<template>
  <div class="hidden lg:block">
    <SvgIcon icon="greenTriangle" class="absolute" style="top: 200px; right: 100px; transform: rotate(125deg); opacity: 0.7" />
    <SvgIcon icon="greenTriangle" class="absolute" style="top: 250px; left: 50px; transform: rotate(20deg); opacity: 0.8" />
    <SvgIcon icon="greenTriangle" class="absolute" style="top: 480px; left: 250px; transform: rotate(95deg); opacity: 0.2" />
    <SvgIcon icon="greenTriangle" class="absolute" style="top: 500px; right: 400px; transform: rotate(60deg); opacity: 1" />
    <SvgIcon icon="greenTriangle" class="absolute" style="top: 650px; right: 250px; transform: rotate(135deg); opacity: 0.8" />
    <SvgIcon icon="greenTriangle" class="absolute" style="top: 750px; left: 50px; transform: rotate(50deg); opacity: 0.7" />
    <SvgIcon icon="bgDots" class="absolute" style="top: 650px; right: 125px;" />
    <SvgIcon icon="bgDots" class="absolute" style="top: 660px; right: 125px;" />
    <SvgIcon icon="bgDots" class="absolute" style="top: 670px; right: 125px;" />
    <SvgIcon icon="bgDots" class="absolute" style="top: 680px; right: 125px;" />
    <SvgIcon icon="bgDots" class="absolute" style="top: 690px; right: 125px;" />
    <SvgIcon icon="bgDots" class="absolute" style="top: 700px; right: 125px;" />
    <SvgIcon icon="bgDots" class="absolute" style="top: 710px; right: 125px;" />
    <SvgIcon icon="bgDots" class="absolute" style="top: 720px; right: 125px;" />
    <SvgIcon icon="bgDots" class="absolute" style="top: 730px; right: 125px;" />
    <SvgIcon icon="bgDots" class="absolute" style="top: 740px; right: 125px;" />
    <SvgIcon icon="bgBlur" class="absolute" style="top: 160px; left: -200px; transform: rotate(180deg); opacity: 0.25;" />
    <SvgIcon icon="bgBlur" class="absolute" style="top: 160px; right: -200px; transform: rotate(-180deg); opacity: 0.25;" />
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