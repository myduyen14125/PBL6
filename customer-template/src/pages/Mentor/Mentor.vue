<template>
  <GuestLayout>
    <div class="mentor-wrapper">
      <section class="banner-section">Cong dong mentor PBL6 hehehehe</section>
      <section class="mentor-section">
        <div class="container">
          <SearchBar />
          <section class="mentors">
            <div class="container">
              <div class="row">
                <div
                  v-for="mentor in mentors"
                  :key="mentor.id"
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
