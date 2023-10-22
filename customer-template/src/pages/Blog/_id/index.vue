<template>
  <GuestLayout>
    <div class="blog-page">
      <div class="container py-lg-5 py-3">
        <div class="row">
          <div class="col-lg-9">
            <section>
              <h3 class="text-uppercase fw-600">
                {{ blogDetail?.title || "" }}
              </h3>
              <div class="d-flex align-items-center py-3">
                <img :src="avatar" class="avatar-img mx-3" />
                <div>
                  <p class="author mb-0">{{ blogDetail?.user?.name || "" }}</p>
                  <p class="job mb-1">CEO tại Babylux Viet Nam</p>
                  <p class="mb-0">
                    {{
                      `Đăng ngày ${
                        formatDate(blogDetail?.createAt, "DD/MM/YYYY") || ""
                      }`
                    }}
                  </p>
                </div>
              </div>
              <div class="content py-3">
                <div
                  v-if="blogDetail?.content"
                  v-html="blogDetail?.content"
                ></div>
              </div>
            </section>
            <section>
              <h4 class="fw-600 color-primary">
                Các mentor có thể bạn quan tâm
              </h4>
              <div>
                <el-carousel
                  :interval="3000"
                  arrow="always"
                  type="card"
                  height="400px"
                  class="my-4"
                >
                  <el-carousel-item v-for="mentor in mentors" :key="mentor._id">
                    <MentorCard :mentor="mentor" :hover="false" />
                  </el-carousel-item>
                </el-carousel>
              </div>
              <div class="my-4 text-center">
                <a class="btn btn-primary px-5 border-18" href="/mentors"
                  >Xem thêm</a
                >
              </div>
            </section>
            <section>
              <h4 class="fw-600 color-primary">Thảo luận</h4>
              <div class="my-4">
                <textarea
                  rows="5"
                  class="form-control"
                  placeholder="Chia sẽ cảm nghĩ của bạn về bài viết"
                ></textarea>
              </div>
              <div class="text-end">
                <button class="btn btn-primary">Đăng bình luận</button>
              </div>
              <div class="comments">
                <div v-for="n in 3" :key="n" class="border rounded p-3 my-3">
                  <div class="d-flex align-items-center py-3">
                    <img :src="avatar" class="avatar-img mx-3" />
                    <div>
                      <p class="author mb-0">Chí Hoàng Dương</p>
                      <p class="mb-0">Đăng ngày 16-02-2023</p>
                    </div>
                  </div>
                  <p>Bài viết thật bổ ích.</p>
                </div>
              </div>
            </section>
          </div>
          <div class="col-lg-3">
            <section>
              <a href="#" target="_blank">
                <img
                  class="w-100 px-2"
                  :src="advertisementImg"
                  alt="Advertisement"
                />
              </a>
            </section>
          </div>
        </div>
      </div>
    </div>
  </GuestLayout>
</template>

<script>
import { ref, onMounted } from "vue";
import SvgIcon from "../../../components/BUI/SvgIcon/SvgIcon.vue";
import avatar from "../../../assets/image/avatar.png";
import advertisementImg from "../../../assets/image/advertisement.jpg";
import GuestLayout from "../../../layout/GuestLayout/GuestLayout.vue";
import MentorCard from "../../../components/MentorCard/MentorCard.vue";
import { useMentors } from "../../../stores/mentors";
import { useBlog } from "../../../stores/blog";
import SwalPopup from "../../../ultils/swalPopup";
import { formatDate } from "../../../ultils/date";
import { GetMentorsParams } from "../../../types/mentor";

export default {
  components: {
    SvgIcon,
    GuestLayout,
    MentorCard,
  },
  props: {
    id: {
      type: String,
      required: true,
    },
  },
  setup(props) {
    const mentorsStore = useMentors();
    const blogStore = useBlog();
    const mentors = ref([]);
    const blogDetail = ref();

    onMounted(() => {
      getMentors();
      getBlogDetail();
    });

    const getMentors = () => {
      mentorsStore.requestGetMentors({
        params: { page: 1, limit: 15 } as GetMentorsParams,
        callback: {
          onSuccess: (res) => {
            mentors.value = res.mentors;
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
          },
        },
      });
    };

    const getBlogDetail = () => {
      blogStore.requestGetBlogById({
        id: props?.id,
        callback: {
          onSuccess: (res) => {
            blogDetail.value = res;
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
          },
        },
      });
    };

    return {
      avatar,
      mentors,
      advertisementImg,
      blogDetail,
      formatDate,
    };
  },
};
</script>

<style scoped lang="css">
.avatar-img {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  object-fit: cover;
}

.sub-title {
  font-size: 16px;
  font-weight: 600;
  color: #333333;
  line-height: 22px;
  text-align: justify;
  text-justify: inter-word;
}

.author {
  font-weight: 600;
  color: var(--primary);
}

.job {
  color: #949ba1;
}
</style>
