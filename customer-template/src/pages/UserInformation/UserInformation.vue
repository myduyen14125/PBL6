<template>
  <GuestLayout>
    <div class="container py-lg-5 py-3">
      <div class="row">
        <div class="col-lg-9">
          <div class="box">
            <div class="profile-cover">
              <img :src="coverImg" class="coverImg" />
              <div class="overlay">
                <div class="p-3 avatar-img" @click="clickInputFile">
                  <img
                    :src="userInfo?.avatar || fileImage || avatarImg"
                    alt="avatar"
                    ref="avatarSrc"
                  />
                  <SvgIcon
                    v-if="showEdit"
                    class="cameraIcon"
                    icon="cameraIcon"
                  />
                  <input
                    v-if="showEdit"
                    ref="fileRef"
                    class="cameraInput"
                    type="file"
                    id="avatar"
                    name="avatar"
                    accept="image/*"
                    @change="toggleAvatar"
                  />
                </div>
                <div class="px-4 d-flex flex-column justify-content-center">
                  <div class="username">{{ userInfo?.name || "" }}</div>
                  <div class="position-user">HR Manager taị VNG</div>
                </div>
              </div>
            </div>
            <div
              v-if="userInfo?.role == 'mentor'"
              class="pt-3 d-flex flex-wrap align-items-center"
            >
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
              <div v-if="!showEdit">
                <div>
                  <!-- @click="bookAppointment" -->
                  <button
                    v-if="getUserInfo()?.role !== 'mentor'"
                    className="btn btn-primary px-4 action-button my-2"
                    @click="
                      () => router.push(`/book-appointment/${userInfo._id}`)
                    "
                  >
                    Đặt lịch ngay
                  </button>
                </div>
                <div>
                  <button className="btn btn-primary px-4 action-button">
                    Theo dõi
                  </button>
                </div>
              </div>
            </div>
          </div>
          <div class="user-action">
            <label class="tab px-4 text">
              <input
                type="radio"
                name="radio-action"
                value="profile"
                v-model="selectedOption"
                :class="{
                  active: selectedOption == 'profile',
                }"
              /><span>Hồ sơ</span>
            </label>
            <label class="tab px-4 text">
              <input
                type="radio"
                name="radio-action"
                value="evaluation"
                v-model="selectedOption"
                :class="{
                  active: selectedOption == 'evaluation',
                }"
              /><span>Đánh giá(2)</span>
            </label>
            <template v-if="userInfo?.role == 'mentor'">
              <label class="tab px-4 text">
                <input
                  type="radio"
                  name="radio-action"
                  value="recommend"
                  v-model="selectedOption"
                  :class="{
                    active: selectedOption == 'recommend',
                  }"
                /><span>Đề xuất</span>
              </label>
              <label class="tab px-4 text">
                <input
                  type="radio"
                  name="radio-action"
                  value="post"
                  v-model="selectedOption"
                  :class="{
                    active: selectedOption == 'post',
                  }"
                /><span>{{ `Bài đăng (${userBlogs.length})` }}</span>
              </label>
            </template>
          </div>
          <div class="box" v-if="selectedOption === 'profile'">
            <div class="user-section">
              <div class="flex-center-between">
                <h5>
                  {{ `CHƯƠNG TRÌNH MENTOR CỦA ${userInfo?.name || ""}` }}
                </h5>
              </div>
              <div>
                <el-carousel :interval="4000" height="200px" arrow="always">
                  <el-carousel-item v-for="item in 6" :key="item">
                    <div class="card d-block w-100">
                      <span class="text-span"
                        >Định hướng và chia sẻ kinh nghiệm nghề nghiệp</span
                      >
                      <div class="content-card text">
                        Management Trainee - Talent Acquistion & Employer
                        Branding | People Development tại L'Oreal Việt Nam
                      </div>
                      <br />
                      <a href="#">Xem thêm</a>
                    </div>
                  </el-carousel-item>
                </el-carousel>
              </div>
            </div>
            <div class="user-section">
              <div class="flex-center-between">
                <h5>GIỚI THIỆU BẢN THÂN</h5>
                <p v-if="showEdit" class="btn btn-primary px-3">Thêm</p>
              </div>

              <div>
                Hello young talent, I am happy to have a chance to talk and
                sharing with you about the career orientation and job mentoring.
                If you want to connect with me, feel free to add my fb:
                fb.com/linh.le.1237
              </div>
            </div>
            <div class="user-section">
              <div class="flex-center-between">
                <h5>KINH NGHIỆM LÀM VIỆC</h5>
                <p
                  v-if="showEdit"
                  class="btn btn-primary px-3"
                  @click="toggleExperience"
                >
                  Thêm
                </p>
              </div>
              <div v-for="item in userInfo?.bio.experiences" :key="item._id">
                <ExperienceCard
                  :showEdit="showEdit"
                  :data="item"
                  @updatedCard="() => getUserInformation(id)"
                  type="experience"
                  :bio="userInfo?.bio?._id || ''"
                />
              </div>
            </div>
            <div class="user-section">
              <div class="flex-center-between">
                <h5>QUÁ TRÌNH HỌC TẬP</h5>
                <p
                  v-if="showEdit"
                  class="btn btn-primary px-3"
                  @click="toggleEducation"
                >
                  Thêm
                </p>
              </div>
              <div v-for="item in userInfo?.bio.educations" :key="item._id">
                <ExperienceCard
                  :showEdit="showEdit"
                  :data="item"
                  @updatedCard="() => getUserInformation(id)"
                  type="education"
                  :bio="userInfo?.bio?._id || ''"
                />
              </div>
            </div>
            <div class="user-section">
              <div class="flex-center-between">
                <h5>GIẢI THƯỞNG</h5>
                <p
                  v-if="showEdit"
                  class="btn btn-primary px-3"
                  @click="toggleAward"
                >
                  Thêm
                </p>
              </div>
              <div v-for="item in userInfo?.bio.awards" :key="item._id">
                <ExperienceCard
                  :showEdit="showEdit"
                  :data="item"
                  @updatedCard="() => getUserInformation(id)"
                  type="award"
                  :bio="userInfo?.bio?._id || ''"
                />
              </div>
            </div>
            <div class="user-section">
              <div class="flex-center-between">
                <h5>KỸ NĂNG & CHỨNG CHỈ</h5>
                <p v-if="showEdit" class="btn btn-primary px-3">Thêm</p>
              </div>
              <div v-for="item in userInfo?.bio.skills" :key="item._id">
                <ExperienceCard
                  :showEdit="showEdit"
                  :data="item"
                  @updatedCard="() => getUserInformation(id)"
                />
              </div>
            </div>
          </div>
          <div class="box" v-else-if="selectedOption === 'evaluation'">
            <div v-for="n in 2" :key="n" class="w-100 border-bottom mb-3">
              <div class="row">
                <div class="col-2 flex-center-center">
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
          <div class="box" v-else-if="selectedOption === 'recommend'"></div>
          <div class="box" v-else-if="selectedOption === 'post'">
            <div v-for="blog in userBlogs" :key="blog._id" class="p-3">
              <MentorPost :blog="blog" />
            </div>
          </div>
        </div>
        <div class="col-lg-3">
          <div class="advertisement">
            <a href="#" target="_blank">
              <img class="w-100" :src="advertisementImg" alt="Advertisement" />
            </a>
          </div>
          <div class="pt-5">
            <h5 class="ps-2">Có thể bạn quan tâm</h5>
            <div
              class="row py-2 cursor-pointer"
              v-for="mentor in mentors"
              :key="mentor?._id"
              @click="router.push(`/user/${mentor?._id}`)"
            >
              <div class="col-3">
                <img :src="hourLogo" class="mini-ava" />
              </div>
              <div class="col-9">
                <div class="basic-intro">
                  <div class="author">{{ mentor?.name || "" }}</div>
                  <span class="text-span"
                    >English Teacher (full-time) tại ULIS Middle School (UMS),
                    ULIS</span
                  >
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </GuestLayout>
  <AvatarModal
    ref="avatarModal"
    @updated="uploadAvatar"
    :avatar="getAvatar()"
  />
  <ExperienceModal
    ref="experienceModal"
    :bio="userInfo?.bio?._id || ''"
    @updatedModal="() => getUserInformation(id)"
  />

  <EducationModal
    ref="educationModal"
    :bio="userInfo?.bio?._id || ''"
    @updatedModal="() => getUserInformation(id)"
  />
  <AwardModal
    ref="awardModal"
    :bio="userInfo?.bio?._id || ''"
    @updatedModal="() => getUserInformation(id)"
  />
</template>

<script lang="ts" src="./UserInformation.ts"></script>
<style scoped lang="css" src="./style.css"></style>
