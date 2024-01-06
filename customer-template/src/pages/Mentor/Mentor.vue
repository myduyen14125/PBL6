<template>
  <GuestLayout>
    <div class="mentor-wrapper">
      <section class="banner-section bg-slate-200">
        <div class="container flex">
          <div class="row">
            <div class="col-lg-8 p-md-5">
              <div class="mx-lg-5">
                <h1 class="mb-5">
                  Cộng đồng Mentor về công nghệ duy nhất tại Việt Nam!
                </h1>
                <p>
                  IT Mentor là nền tảng kết nối cố vấn và học cùng chuyên gia
                  với sứ mệnh nâng cao chất lượng nguồn nhân lực, giúp thanh
                  niên Việt Nam định vị nghề nghiệp và tạo cơ hội phát triển.
                </p>
                <div class="mt-5">
                  <button class="btn btn-primary !text-lg px-4 py-3 mb-3">
                    Đăng ký tư vấn ngay
                  </button>
                  <SearchBar @clickSearch="getSearchParams" />
                </div>
              </div>
            </div>
            <div
              class="col-lg-4 d-flex align-items-center justify-content-center"
            >
              <img :src="imageSaler" alt="Saler image" class="h-[350px]" />
            </div>
          </div>
        </div>
      </section>
      <section class="mentor-section">
        <!-- <section class="majors">
          <div class="container flex flex-wrap justify-center gap-8">
            <div v-for="major in majors" :key="major.name">
              <MajorCard :major="major"></MajorCard>
            </div>
          </div>
        </section> -->
        <section class="mentors">
          <div class="container">
            <div class="row">
              <div
                v-if="isLoading"
                class="col-12 d-flex align-items-center justify-content-center"
              >
                <div class="spinner-border text-info" role="status"></div>
              </div>
              <div
                v-else
                v-for="mentor in mentors"
                :key="mentor._id"
                class="col-12 col-sm-6 col-md-4 col-lg-3"
              >
                <MentorCard :mentor="mentor"></MentorCard>
              </div>
            </div>
            <div class="my-5 d-flex" v-if="!isLoading">
              <el-pagination
                class="ms-auto"
                v-model:current-page="searchValue.page"
                :page-size="limit"
                background
                layout="prev, pager, next"
                :total="totalElement"
                @current-change="searchMentor"
              />
            </div>
          </div>
        </section>
      </section>
    </div>
  </GuestLayout>
</template>
<script lang="ts" src="./Mentor.ts"></script>
<style scoped lang="css" src="./style.css"></style>
