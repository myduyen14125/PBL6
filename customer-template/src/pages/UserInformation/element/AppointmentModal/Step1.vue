<template>
  <div>
    <div class="progress">
      <div
        class="progress-bar background-primary progress-bar-striped"
        role="progressbar"
        style="width: 25%"
        aria-valuenow="25"
        aria-valuemin="0"
        aria-valuemax="100"
      >
        25%
      </div>
    </div>
    <div class="d-flex align-items-center my-4">
      <SvgIcon icon="handIcon" class="me-3" />
      <h5 class="color-primary mb-0">Chọn thời gian</h5>
      <Qalendar 
        :events="events"
        :config="config"
      />
    </div>
  </div>
</template>

<script>
import SvgIcon from "../../../../components/BUI/SvgIcon/SvgIcon.vue";
import { Qalendar } from "qalendar";

export default {
  components: { SvgIcon, Qalendar },
  data() {
      return {
          events: [
              // ...
              {
                title: "Advanced algebra",
                with: "Chandler Bing",
                time: { start: "2022-05-16 12:05", end: "2022-05-16 13:35" },
                color: "yellow",
                isEditable: true,
                id: "753944708f0f",
                description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Asperiores assumenda corporis doloremque et expedita molestias necessitatibus quam quas temporibus veritatis. Deserunt excepturi illum nobis perferendis praesentium repudiandae saepe sapiente voluptatem!"
              },
              {
                title: "Ralph on holiday",
                with: "Rachel Greene",
                time: { start: "2022-05-10", end: "2022-05-22" },
                color: "green",
                isEditable: true,
                id: "5602b6f589fc"
              }
              // ...
          ],
          config: {
            // see configuration section
          }
      }
  },
  setup() {},
};
</script>

<style scoped lang="css">
  @import "qalendar/dist/style.css";
</style>


