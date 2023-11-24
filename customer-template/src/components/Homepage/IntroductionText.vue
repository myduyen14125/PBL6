<template>
  <div class="container">
          <div class="row">
            <div class="pt-16 mb-12 mx-auto max-w-7xl px-4 sm:mt-20 text-center">
              <p class="text-teal-900 text-md font-normal leading-7 mt-2 mb-6">
                Học từ một chuyên gia, sáng tạo một dự án, đạt được sự nghiệp mơ ước của bạn.
              </p>
              <h1 class="font-normal text-6xl tracking-tight leading-tighter">
                <span class="font-bold text-navy-900">1-on-1 - </span>
                <span class="font-bold text-teal-600">
                  {{ currentText }}
                  <span v-if="showCursor">|</span>
                </span>
              </h1>
              <h1 class="font-normal text-6xl tracking-tight leading-tighter">
                <span class="font-bold text-navy-900">IT Mentor</span>
              </h1>
            </div>
            
          </div>
        </div>
</template>
<script>
import { computed, defineComponent, onMounted, ref } from "vue";

export default defineComponent({
  components: { },
  setup() {
    const textIndex = ref(0);
    const charIndex = ref(0);
    const showCursor = ref(true);
    const textArray = ["Kết nối", "Phát triển", "Định hướng"];

    const currentText = computed(() => {
      const currentWord = textArray[textIndex.value];
      return currentWord.substring(0, charIndex.value);
    });

    onMounted(() => {
      setInterval(typeText, 300);
    });

    const typeText = () => {
      if (charIndex.value < textArray[textIndex.value].length) {
        charIndex.value += 1;
        showCursor.value = true;
      } else {
        showCursor.value = false;
        setTimeout(() => {
          charIndex.value = 0;
          textIndex.value = (textIndex.value + 1) % textArray.length;
        }, 300);
      }
    };

    return {
      currentText,
      showCursor,
    };
  },
});

</script>