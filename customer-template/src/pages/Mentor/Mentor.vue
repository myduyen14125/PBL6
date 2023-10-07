<template>
  <GuestLayout>
    <div class="mentor-wrapper">
      <section class="banner-section bg-slate-200">
        <div class="container flex">
          <div class="w-3/5">
            <h1 class="font-bold">Cộng đồng Mentor về công nghệ duy nhất tại Việt Nam!</h1>
            <p class="text-xl mt-4">
              IT Mentor là nền tảng kết nối cố vấn và học cùng chuyên gia với sứ
              mệnh nâng cao chất lượng nguồn nhân lực, giúp thanh niên Việt Nam
              định vị nghề nghiệp và tạo cơ hội phát triển.
            </p>
            <div class="mt-5">
              <button class="btn btn-primary !text-lg px-4 py-3 mb-3">
                Đăng ký tư vấn ngay
              </button>
              <SearchBar />
            </div>
          </div>
          <div class="w-2/5 pl-12">
            <img
              :src="imageSaler"
              alt="Saler image"
              class="h-[350px]"
             />
          </div>
        </div>
      </section>
      <section class="mentor-section">
        <div class="container">
          <section class="majors flex justify-center gap-8">
            <div
              v-for="major in majors"
              :key="major.name"
            >
              <MajorCard :major="major"></MajorCard>
            </div>
          </section>
          <section class="mentors">
            <div class="container">
              <div class="row">
                <div
                  v-for="mentor in mentors"
                  :key="mentor.name"
                  class="col-12 col-sm-6 col-md-4 col-lg-3"
                >
                  <MentorCard :mentor="mentor"></MentorCard>
                </div>
              </div>
              <div class="my-5 text-center">
                <a class="btn btn-primary px-5 border-18" href="/mentors"
                  >Xem thêm</a
                >
              </div>
            </div>
          </section>
        </div>
      </section>
    </div>
  </GuestLayout>
</template>
<script lang="ts" src="./Mentor.ts"></script>
<style scoped lang="css" src="./style.css"></style>
