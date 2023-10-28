<template>
  <div
    class="appointment-card bg-slate-50 w-fit relative p-3 rounded-lg hover:shadow-md min-w-[300px]"
  >
    <div class="appointment-card__header">
      <div class="appointment-card__header">
        <div class="appointment-card__header__title">
          <h4 class="font-bold text-xl">Lịch hẹn tư vấn nghề nghiệp</h4>
          <p class="text-gray-500 text-md">
            {{ formatDate(appointment?.schedule?.start_at, "DD/MM/YYYY") }}
          </p>
          <div
            class="appointment-card__header__status bg-yellow-500 w-fit px-2 rounded absolute right-3 top-12"
          >
            <span class="text-white text-sm">{{
              appointment?.status || ""
            }}</span>
          </div>
        </div>
      </div>
    </div>
    <div class="appointment-card__body mt-3">
      <div
        class="appointment-card__body__top flex flex-col items-center text-center"
      >
        <div class="appointment-card__body__top__avatar">
          <img
            src="https://picsum.photos/200/300"
            alt="avatar"
            class="w-20 h-20 rounded-full"
          />
        </div>
        <div class="appointment-card__body__top__info mt-2">
          <h4 class="font-bold text-xl m-0">
            {{ appointment?.mentor.name || "" }}
          </h4>
          <p class="text-gray-500 m-0">Chuyên gia tư vấn nghề nghiệp</p>
        </div>
      </div>
      <div class="appointment-card__body__bottom mt-3 flex">
        <div class="appointment-card__body__bottom__time w-2/3">
          <p class="text-gray-500 my-1">Thời gian</p>
          <p class="font-bold m-0">
            {{
              `${formatDate(
                appointment?.schedule?.start_at,
                "hh:ss a"
              )} - ${formatDate(appointment?.schedule?.end_at, "hh:ss a")}`
            }}
          </p>
        </div>
        <div class="appointment-card__body__bottom__time w-1/3">
          <p class="text-gray-500 my-1">Địa điểm</p>
          <p class="font-bold">Online</p>
        </div>
      </div>
      <div class="appointment-card__cancel">
        <button class="btn btn-primary !text-sm">Hủy lịch hẹn</button>
      <div class="appointment-card__action">
        <div class="appointment-card__cancel"  v-if="appointment.status=='pending'">
          <button class="btn btn-danger !text-sm">Hủy lịch hẹn</button>
        </div>
        <div class="appointment-card__confirm" @click="confirmAppointment"  v-if="appointment.status=='pending'">
          <button class="btn btn-primary !text-sm">Xác nhận lịch hẹn</button>
        </div>
        <div class="appointment-card__finish" @click=""  v-if="appointment.status=='confirmed'">
          <button class="btn btn-primary !text-sm">Hoàn tất</button>
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts" src="./Appointment.ts"></script>
<style scoped lang="css" src="./style.css"></style>
