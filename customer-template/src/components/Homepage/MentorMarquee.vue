<template>
  <Vue3Marquee :pause-on-hover="true" class="my-24">
    <div v-for="mentor in mentors" :key="mentor._id">
      <div class="m-2 w-[250px] h-[200px]">

        <div class="drop-shadow-lg rounded-lg p-6 bg-white h-full w-full overflow-hidden">
          <img class="block w-16 h-16 mx-auto rounded-full mx-auto object-cover" :src="mentor.avatar ? mentor.avatar : avatar" alt="Naveed Janvekar">
          <div class="mt-4 text-center whitespace-normal overflow-hidden align-bottom">
            <h4 class="font-bold text-navy-900 whitespace-nowrap">{{ mentor.name }}</h4>
            <span class="text-gray-400 text-sm mt-2" lang="en">{{ mentor?.expertise?.name ? mentor?.expertise?.name : "IT Mentor" }}</span>
          </div>
        </div>
      </div>
    </div>
  </Vue3Marquee>
</template>

<script>
import { defineComponent } from 'vue';
import { Vue3Marquee } from 'vue3-marquee';
import avatar from "../../assets/image/avatar.png";

export default defineComponent({
  components: {
    Vue3Marquee,
  },
  props: {
    mentors: {
      type: Array,
      default: () => [],
    },
  },
  setup() {
    return {
      avatar,
    };
  },
})
</script>
<style scoped lang="css"></style>