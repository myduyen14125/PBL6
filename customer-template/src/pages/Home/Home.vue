<template>
  <GuestLayout>
    <div class="home-page">
      <section class="hero-section">
        <div class="container">
          <div class="row">
            <div class="col-lg-6 p-5">
              <div class="mx-lg-5">
                <h1 class="mb-5">
                  IT Mentor - Nền tảng Kết nối Cố vấn và Học cùng Chuyên gia
                </h1>
                <p>
                  Với sứ mệnh là nâng cao chất lượng nguồn nhân lực, giúp thanh
                  niên Việt Nam định vị nghề nghiệp và tạo cơ hội phát triển
                </p>
                <!-- <p>Các dịch vụ đến từ IT Mentor:</p>
              <div class="mt-5">
                <button class="btn btn-primary border-18 px-3 mr-6 mb-3">
                  Khóa học từ Chuyên gia
                </button>
                <button class="btn btn-primary border-18 px-3 mb-3">
                  Nền tảng IT Mentor
                </button>
              </div> -->
              </div>
            </div>
            <div
              class="col-lg-6 d-flex align-items-center justify-content-center"
            >
              <img :src="heroImg" alt="Image" class="w-50" />
            </div>
          </div>
        </div>
      </section>
      <section class="mentors">
        <div class="container">
          <h2 class="text-center color-primary mb-5">CỐ VẤN NỔI BẬT</h2>
          <div class="row">
            <div
              v-for="(mentor, index) in mentors"
              :key="index"
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
      <section class="mentor-posts">
        <div class="container">
          <h2 class="text-center color-primary mb-5">
            Bài viết chia sẻ từ các chuyên gia
          </h2>
          <div class="row">
            <div v-for="blog in blogs" :key="blog._id" class="col-12">
              <MentorPost :blog="blog" />
            </div>
          </div>
          <div class="my-5 text-center">
            <a class="btn btn-primary px-5 border-18" href="/blogs">Xem thêm</a>
          </div>
        </div>
      </section>
    </div>
  </GuestLayout>
</template>
<script lang="ts" src="./Home.ts"></script>
<style scoped lang="css" src="./style.css"></style>
