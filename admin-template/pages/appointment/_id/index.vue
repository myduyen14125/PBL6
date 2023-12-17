<template>
  <div class="h-100 position-relative">
    <div class="header d-flex justify-content-between">
      <div class="d-flex align-items-center">
        <img
          src="@/assets/icons/icon-back.svg"
          alt=""
          width="20px"
          height="20px"
          class="mr-1 cursor-pointer"
          @click="goBack()"
        />
        <h1 class="title">Appointment Detail</h1>
      </div>
    </div>
    <hr class="my-2" />
    <div class="content">
      <ul>
        <li class="list-item px-3 py-2 d-flex align-items-center h-38">
          <div class="content-title mr-3">Mentor</div>
          <div class="content-desc">
            {{ appointment?.mentor?.name }}
          </div>
        </li>
        <li class="list-item px-3 py-2 d-flex align-items-center h-38">
          <div class="content-title mr-3">Mentee</div>
          <div class="content-desc">
            {{ appointment?.mentee?.name }}
          </div>
        </li>
        <li class="list-item px-3 py-2 d-flex align-items-center h-38">
          <div class="content-title mr-3">Date:</div>
          <div class="content-desc">
            {{
              `${formatDateTime(
                appointment?.schedule?.start_at,
                "DD/MM/YYYY"
              )} ${formatDateTime(
                appointment?.schedule?.start_at,
                "HH:mm"
              )} - ${formatDateTime(appointment?.schedule?.end_at, "HH:mm")}`
            }}
          </div>
        </li>
        <li class="list-item px-3 py-2 d-flex align-items-center">
          <div class="content-title mr-3">Note</div>
          <div class="content-desc">
            {{ appointment?.note }}
          </div>
        </li>
        <li class="list-item px-3 py-2 d-flex">
          <div class="content-title mr-3">Status</div>
          <div class="content-desc">{{ appointment?.status }}</div>
        </li>
        <li class="list-item px-3 py-2 d-flex">
          <div class="content-title mr-3">Link appointment</div>
          <div class="content-desc break-word appointment-link">
            <a :href="appointment?.mentor?.skype_link" target="_blank">{{
              appointment?.mentor?.skype_link
            }}</a>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>
<script>
import moment from "moment";
export default {
  name: "AppointmentDetail",
  layout: "secret",
  data() {
    return {
      appointment: {},
    };
  },
  created() {
    this.$api.appointment
      .getAppointmentById(this.$route.params.id)
      .then((res) => {
        this.appointment = res.data;
      });
  },
  methods: {
    goBack() {
      this.$router.go(-1);
    },

    formatDateTime(date, format) {
      return date ? moment(new Date(date)).format(format) : "";
    },
  },
};
</script>
<style lang="scss" scoped>
@import "@/assets/scss/toggle.scss";
.content {
  overflow: auto;
  height: 90%;
  &-image {
    width: 263px;
    height: 200px;
    object-fit: cover;
    border-radius: 10px;
    &-detail {
      width: 780px;
      height: 340px;
      object-fit: cover;
      border-radius: 10px;
    }
    &-logo {
      width: 86px;
      height: 86px;
      object-fit: cover;
      border-radius: 10px;
    }
  }
  &-title {
    font-weight: 500;
    color: $color-primary;
    width: 296px;
  }
  &-desc {
    color: $color-secondary;
    // width: calc(100% - 236px - 50px);
    width: 60%;
    text-align: justify;
    // margin-left: 14px;
  }
}

.appointment-link {
  a {
    color: $color-blue;
  }
}
</style>
