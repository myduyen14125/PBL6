<template>
  <GuestLayout>
    <div class="container">
      <div class="row">
        <div class="col-lg-9">
          <div class="box">
            <div class="profile-cover">
              <img :src="coverImg" class="coverImg" />
              <div class="overlay">
                <div
                  class="d-flex align-items-center justify-content-center p-3"
                >
                  <img :src="avatarImg" class="avatarImg" />
                </div>
                <div class="px-4 d-flex flex-column justify-content-center">
                  <div class="username">{{ mentorInfo?.name || "" }}</div>
                  <div class="position-user">HR Manager taị VNG</div>
                </div>
              </div>
            </div>
            <div class="pt-3 d-flex flex-wrap align-items-center">
              <div class="flex-fill">
                <div class="d-flex flex-wrap align-items-center">
                  <div class="info-icon">
                    <img :src="personLogo" class="icon" />
                    <span class="text-action"> 65 mentee</span>
                  </div>
                  <div class="info-icon">
                    <img :src="hourLogo" class="icon" />
                    <span class="text-action"> 74h </span>
                  </div>
                </div>
                <div class="d-flex flex-wrap align-items-center">
                  <div class="info-icon">
                    <img :src="ratingLogo" class="icon" />
                    <span class="text-action"> 4.9/5</span>
                  </div>
                  <div class="info-icon">
                    <img :src="heartLogo" class="icon" />
                    <span class="text-action"> 281</span>
                  </div>
                </div>
              </div>
              <div>
                <div>
                  <button
                    className="btn btn-primary px-4 action-button my-2"
                    type="submit"
                  >
                    Đặt lịch ngay
                  </button>
                </div>
                <div>
                  <button
                    className="btn btn-primary px-4 action-button"
                    type="submit"
                  >
                    Theo dõi
                  </button>
                </div>
              </div>
            </div>
          </div>
          <div class="mentor-action">
            <label class="tab text">
              <input
                type="radio"
                name="radio-action"
                value="profile"
                v-model="selectedOption"
                :class="{
                  active: selectedOption == 'profile',
                }"
              /><span> Hồ sơ</span>
            </label>
            <label class="tab text">
              <input
                type="radio"
                name="radio-action"
                value="evaluation"
                v-model="selectedOption"
                :class="{
                  active: selectedOption == 'evaluation',
                }"
              /><span> Đánh giá</span>
            </label>
          </div>
          <div class="box" v-if="selectedOption === 'profile'">
            <div class="program p-2">
              <div class="mentor-infor-header text text-uppercase">
                {{ `CHƯƠNG TRÌNH MENTOR CỦA ${mentorInfo?.name || ""}` }}
              </div>
              <el-carousel :interval="4000" height="200px">
                <el-carousel-item v-for="item in 6" :key="item">
                  <div class="card d-block w-100">
                    <span class="text-span"
                      >Định hướng và chia sẻ kinh nghiệm nghề nghiệp</span
                    >
                    <div class="content-card text">
                      Management Trainee - Talent Acquistion & Employer Branding
                      | People Development tại L'Oreal Việt Nam
                    </div>
                    <br />
                    <a href="#">Xem thêm</a>
                  </div>
                </el-carousel-item>
              </el-carousel>
            </div>
            <hr />
            <div class="introduce p-2">
              <div class="mentor-infor-header text">GIỚI THIỆU BẢN THÂN</div>

              <div class="content-introduce">
                Hello young talent, I am happy to have a chance to talk and
                sharing with you about the career orientation and job mentoring.
                If you want to connect with me, feel free to add my fb:
                fb.com/linh.le.1237
              </div>
            </div>
          </div>
          <div class="box" v-if="selectedOption === 'evaluation'">
            <div
              v-for="n in 2"
              :key="n"
              class="comment-card border-bottom mb-3"
            >
              <div class="row">
                <div class="col-2 col-3-only-img">
                  <img :src="hourLogo" class="mini-ava" />
                </div>
                <div class="col-6">
                  <div class="basic-intro">
                    <div>Minh Nguyệt</div>
                    <span class="text-span"
                      >English Teacher (full-time) tại ULIS Middle School (UMS),
                      ULIS</span
                    >
                  </div>
                </div>
              </div>
              <div class="content-comment">
                Buổi cố vấn thật ý nghĩa với mình trong lúc mình cảm thấy vô
                cùng peer pressure và trống rỗng. Em cảm ơn chị Linh vì đã đưa
                ra những phân tích và lời khuyên đúng đắn cho em. Chị rất nhiệt
                tình và tâm huyết để giúp mình tìm được giải pháp và hướng đi
                tiếp theo.
              </div>
            </div>
          </div>
        </div>
        <div class="col-lg-3">
          <div class="sub-section">
            <div class="advertisement">
              <a href="https://dut.udn.vn/" target="_blank">
                <img
                  class="advertisement-img"
                  :src="advertisementImg"
                  alt="Advertisement"
                />
              </a>
            </div>
            <div class="recommendation pt-5">
              <div class="mentor-infor-header text">Có thể bạn quan tâm</div>

              <div class="recommendation-content">
                <div class="sub-card">
                  <a v-for="n in 2" :key="2" href="#">
                    <div class="row">
                      <div class="col-3 col-3-only-img">
                        <img :src="hourLogo" class="mini-ava" />
                      </div>
                      <div class="col-9">
                        <div class="basic-intro">
                          <div>Minh Nguyệt</div>
                          <span class="text-span"
                            >English Teacher (full-time) tại ULIS Middle School
                            (UMS), ULIS</span
                          >
                        </div>
                      </div>
                    </div>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </GuestLayout>
</template>

<script lang="ts" src="./MentorInformation.ts"></script>
<style scoped lang="css" src="./style.css"></style>
