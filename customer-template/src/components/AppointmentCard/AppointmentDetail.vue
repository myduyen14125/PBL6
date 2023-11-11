<template>
  <div class="">
    <h2 class="text-[#0a5565] font-700 text-center">Xác nhận thông tin cuộc hẹn</h2>

    <div class="flex mt-16 w-4/5 mx-auto font-700">

      <div class="w-1/2 border border-[#0a5565] px-4 py-8 rounded-md text-[#0a5565] shadow-md mr-4">
        <div class="mb-4">
          <img :src="userInfo.avatar" class="w-40 h-40 rounded-full mx-auto object-cover" />
        </div>
        <p class="text-lg">
          <span class="font-bold inline-block w-40">Tên mentor: </span>
          {{ userInfo.name }}
        </p>
        <p class="text-lg">
          <span class="font-bold inline-block w-40">Lĩnh vực: </span>
          {{ userInfo.expertise.name }}
        </p>
        <p class="text-lg">
          <span class="font-bold inline-block w-40">Email liên lạc: </span>
          {{ userInfo.email }}
        </p>
        <p class="text-lg">
          <span class="font-bold inline-block w-40">Số điện thoại: </span>
          {{ userInfo.phone }}
        </p>
      </div>
      <div class="w-1/2 border border-[#0a5565] px-4 py-8 rounded-md text-[#0a5565] shadow-md ml-4">
        <p class="text-lg">
          <span class="font-bold inline-block w-40">Ngày hẹn: </span>
          {{ selectedSchedule.start.split(" ")[0] }}
        </p>
        <p class="text-lg">
          <span class="font-bold inline-block w-40">Thời gian hẹn: </span>
          {{ selectedSchedule.start.split(" ")[1] }} - {{ selectedSchedule.end.split(" ")[1] }}
        </p>
        <p class="text-lg">
          <span class="font-bold inline-block w-40">Hình thức kết nối: </span>
          <span class="text-[#139896]">Online</span>
        </p>
        <p class="text-lg">
          <span class="font-bold inline-block w-40">Ghi chú: </span>
          <textarea v-model="note" class="w-full border border-[#0a5565] rounded-md p-2 mt-2" rows="7" @change="emitNote"></textarea>
        </p>

      </div>

    </div>

  </div>
</template>
<script>
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import SvgIcon from "../../components/BUI/SvgIcon/SvgIcon.vue";
import FullCalendar from "@fullcalendar/vue3";

export default {
  components: { GuestLayout, SvgIcon, FullCalendar },
  props: {
    userInfo: {
      type: Object,
      required: true,
    },
    selectedSchedule: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      note: "",
    };
  },
  methods: {
    emitNote() {
      this.$emit("note", this.note);
    },
  }

};
</script>
<style lang="css" scoped></style>