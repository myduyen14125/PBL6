<template>
  <GuestLayout>
    <div class="wrapper">
      <div class="row">
        <div class="col-9">
          <div class="box">
            <div class="profile-cover">
              <img :src="coverImg" class="coverImg" />
              <div class="overlay">
                <div class="row w-100">
                  <div class="col-3 d-flex align-items-center avatar">
                    <img :src="avatarImg" class="avatarImg mx-auto" />
                  </div>
                  <div class="col-6 d-flex flex-column text-left p-4">
                    <div class="basic-intro">
                      <div class="username">{{ mentorInfo?.name || "" }}</div>
                      <div class="position-user">HR Manager taị VNG</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="profile-action">
              <div class="row">
                <div class="col-3">
                  <div class="infor-icon">
                    <img :src="personLogo" class="icon" />
                    <span class="text-action"> 65 mentee</span>
                  </div>
                </div>
                <div class="col-3">
                  <div class="infor-icon">
                    <img :src="hourLogo" class="icon" />
                    <span class="text-action"> 74h </span>
                  </div>
                </div>
                <div class="col-6 text-end">
                  <div class="">
                    <button
                      className="btn btn-primary px-4 action-button"
                      type="submit"
                    >
                      Đặt lịch ngay
                    </button>
                  </div>
                </div>
              </div>
              <div class="row pt-2">
                <div class="col-3">
                  <div class="infor-icon">
                    <img :src="ratingLogo" class="icon" />
                    <span class="text-action"> 4.9/5</span>
                  </div>
                </div>
                <div class="col-3">
                  <div class="infor-icon">
                    <img :src="heartLogo" class="icon" />
                    <span class="text-action"> 281</span>
                  </div>
                </div>
                <div class="col-6 text-end">
                  <div class="">
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
          </div>
          <div class="mentor-action">
            <label class="profile-label text">
              <input
                type="radio"
                name="radio-action"
                value="profile"
                v-model="selectedOption"
              /><span> Hồ sơ</span>
            </label>
            <label class="evaluation-label text">
              <input
                type="radio"
                name="radio-action"
                value="evaluation"
                v-model="selectedOption"
              /><span> Đánh giá</span>
            </label>
          </div>
          <div class="box" v-if="selectedOption === 'profile'">
            <div class="program">
              <div class="mentor-infor-header text text-uppercase">
                {{ `CHƯƠNG TRÌNH MENTOR CỦA ${mentorInfo?.name || ""}` }}
              </div>

              <div class="content-program">
                <div class="card">
                  <span class="text-span">Kỹ năng mềm</span>
                  <div class="content-card text">
                    Kỹ năng viết CV và phỏng vấn
                  </div>
                  <br />
                  <a href="#">Xem thêm</a>
                </div>
                <div class="card">
                  <span class="text-span"
                    >Định hướng và chia sẻ kinh nghiệm nghề nghiệp</span
                  >
                  <div class="content-card text">
                    Management Trainee - Talent Acquistion & Employer Branding |
                    People Development tại L'Oreal Việt Nam
                  </div>
                  <br />
                  <a href="#">Xem thêm</a>
                </div>
              </div>
            </div>
            <hr />
            <div class="introduce">
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
            <div class="comment-card">
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
            <hr />
            <div class="comment-card">
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
        <div class="col-3">
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
                  <a href="#">
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
                  <a href="#">
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
