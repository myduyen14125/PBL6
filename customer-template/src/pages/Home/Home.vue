<template>
  <GuestLayout>
    <div class="home-page">
      <section class="hero-section">
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
        <div class="search-wrapper shadow-lg rounded-lg w-fit mx-auto px-4 py-2 flex items-center">
          <SearchBar @clickSearch="getSearchParams"/>
        </div>
        <HiddenBackground /> 
        <MentorMarquee :mentors="mentors" />
      </section>
      <section class="banner-section">
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
                <p class="mt-3">Các dịch vụ đến từ IT Mentor:</p>
                <div class="mt-3">
                  <button
                    class="btn btn-primary !text-lg border-10 px-3 py-2 mr-6 mb-3"
                  >
                    Tư vấn trực tiếp
                  </button>
                  <button
                    class="btn btn-primary !text-lg border-10 px-3 py-2 mb-3"
                  >
                    Khóa học cùng chuyên gia
                  </button>
                </div>
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
              v-if="isLoadingMentor"
              class="col-12 d-flex align-items-center justify-content-center"
            >
              <div class="spinner-border text-info" role="status"></div>
            </div>
            <div
              v-else
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
            <div
              v-if="isLoadingBlog"
              class="col-12 d-flex align-items-center justify-content-center"
            >
              <div class="spinner-border text-info" role="status"></div>
            </div>
            <div v-else v-for="blog in blogs" :key="blog._id" class="col-12">
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
