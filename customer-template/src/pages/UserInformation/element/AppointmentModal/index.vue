<template>
  <BModal
    v-model:modal="modal"
    id="book_appointment"
    :title="`Đặt lịch hẹn với Ngà`"
    size="lg"
    animation="fade"
    :noCloseOnBackdrop="true"
    ><template v-slot:body>
      <Step1 />
      <TestCalendar />
    </template>
    <template v-slot:footer>
      <button type="submit" classes="btn btn-primary">Add label</button>
    </template>
  </BModal>
</template>

<script>
import { ref, onMounted, computed, watch } from "vue";
import { useRoute } from "vue-router";
import Step1 from "./Step1.vue";
import TestCalendar from "./TestCalendar.vue"; 
import BModal from "../../../../components/BUI/BModal/BModal.vue";

export default {
  components: {
    Step1,
    BModal,
  },
  setup() {
    const route = useRoute();
    const modal = ref(false);
    const step = ref(1);

    onMounted(() => {});

    const stepParam = computed(() => {
      return route.hash;
    });

    watch(stepParam, (newValue, oldValue) => {
      console.log(`Message changed from ${oldValue} to ${newValue}`);
    });

    const show = () => {
      modal.value = true;
    };

    const hide = () => {
      modal.value = false;
    };
    return { modal, show, hide };
  },
};
</script>

<style scoped lang="css"></style>
