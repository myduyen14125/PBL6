<template>
  <div class="section-wrapper">
    <div class="bg-navy-900 text-white">
      <div class="mx-auto py-12 px-4 max-w-7xl sm:px-6 lg:px-8 lg:py-24">
        <div class="space-y-12">
          <div class="mx-auto space-y-5 sm:space-y-4 md:max-w-xl lg:max-w-3xl xl:max-w-none">
            <h2 class="text-3xl lg:text-center mx-auto max-w-2xl text-white font-bold tracking-tight sm:text-4xl">
              Cơ hội trong tầm tay bạn: kết nối trực tiếp với Mentor.</h2>
            <p class="text-xl lg:text-center mx-auto max-w-3xl">Bạn muốn thành công trong buổi phỏng vấn tiếp theo?
              Bạn muốn xây dựng nền tảng kiến thức vững chắc? Hay nâng cao những kiến thức "khó nhằn" trong công cuộc học
              IT? Hãy tiếp cận một cách thông minh và có hiệu quả hơn thông qua chúng tôi.
              <br><br>
              Hãy trở thành một thành viên của IT Mentor ngay hôm nay!
            </p>
          </div>
          <ul class="space-y-4 sm:grid sm:grid-cols-1 sm:gap-6 sm:space-y-0 lg:grid-cols-3 lg:gap-8">

            <li class="text-white bg-navy-900">
              <div class="p-6 text-left rounded-lg xl:px-10">
                <div class="space-y-2">
                  <div class="space-y-2 xl:flex xl:items-center xl:justify-between">
                    <div class="font-medium text-lg leading-6 space-y-1">
                      <div class="flex justify-center">
                        <h3 class="font-bold text-2xl w-auto h-auto">Tìm kiếm Mentor</h3>
                      </div>
                      <div class="flex justify-center px-10 py-4">
                        <img src="https://cdn.mentorcruise.com/img/home/icons/mc-logo.svg" alt="ITMentor">
                      </div>
                      <div>
                        <p class="my-4 text-base text-center">Khám phá danh mục mentor giàu kinh nghiệm của chúng tôi cho
                          đến khi bạn tìm được người phù hợp hoàn hảo.</p>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </li>

            <li class="text-white bg-navy-900">
              <div class="p-6 text-left rounded-lg xl:px-10">
                <div class="space-y-2">
                  <div class="space-y-2 xl:flex xl:items-center xl:justify-between">
                    <div class="font-medium text-lg leading-6 space-y-1">
                      <div class="flex justify-center">
                        <h3 class="font-bold text-2xl w-auto h-auto">Kết nối trực tuyến</h3>
                      </div>
                      <div class="flex justify-center px-10 py-4">
                        <img src="https://cdn.mentorcruise.com/img/home/icons/mc-edit.svg" alt="ITMentor">
                      </div>
                      <div>
                        <p class="my-4 text-base text-center">Kết nối trực tuyến 1 - 1 thông qua các buổi gặp mặt hoặc
                          trải nghiệm khóa học đến từ mentor.</p>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </li>

            <li class="text-white bg-navy-900">
              <div class="p-6 text-left rounded-lg xl:px-10">
                <div class="space-y-2">
                  <div class="space-y-2 xl:flex xl:items-center xl:justify-between">
                    <div class="font-medium text-lg leading-6 space-y-1">
                      <div class="flex justify-center">
                        <h3 class="font-bold text-2xl w-auto h-auto">Nâng cao kĩ năng</h3>
                      </div>
                      <div class="flex justify-center px-10 py-4">
                        <img src="https://cdn.mentorcruise.com/img/home/icons/mc-rocket.svg" alt="ITMentor">
                      </div>
                      <div>
                        <p class="my-4 text-base text-center">Mỗi mentor cung cấp các dịch vụ khác nhau để giúp bạn thăng
                          tiến nhanh chóng trong sự nghiệp của mình.</p>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </li>
          </ul>

          <div class="flex flex-col md:flex-row justify-center items-center space-y-4 md:space-y-0 md:space-x-4">
            <button 
              class="btn btn-primary !text-lg border-10 px-3 py-2 mr-6 mb-3"
              @click = "() => router.push(`/mentors`)"
            >
              Lựa chọn mentor ngay!
            </button>

          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
</script>
<style lang="css" scoped>
.section-wrapper {
  background-color: #004b5c;
}
</style>
<script lang="ts">
import { computed, defineComponent, onMounted, ref } from "vue";
import { useRouter } from "vue-router";

export default defineComponent({
  name: "ProcessSection",
  setup() {
    const router = useRouter();

    return {
      router,
    };
  },
});
</script>