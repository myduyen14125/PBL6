<template>
  <GuestLayout>
    <div class="appointment-wrapper">
      <div class="container py-20 text-lg">
        <div class="row">
          <div class="col-3 col-md-3">
            <SvgIcon icon="calendarFull" />
          </div>
          <div class="col-md-12 col-lg-9">
            <h1 class="text-left font-bold text-4xl mb-4">Lịch hẹn của tôi</h1>
            <el-tabs v-model="activeName" @tab-click="handleClick">
              <el-tab-pane label="Đang xử lý" name="first">
                <div class="flex flex-wrap gap-4 list-card">
                  <div
                    v-if="isLoadingAppointment"
                    class="col-12 d-flex align-items-center justify-content-center"
                  >
                    <div class="spinner-border text-info" role="status"></div>
                  </div>
                  <div
                    v-else
                    v-for="appointment in appointments.pending"
                    :key="appointment?._id"
                  >
                    <AppointmentCard :appointment="appointment" @getAllUserAppointment="getAllUserAppointment" />
                  </div>
                </div>
              </el-tab-pane>
              <el-tab-pane label="Đã xác nhận" name="second"
                ><div
                  v-if="isLoadingAppointment"
                  class="col-12 d-flex align-items-center justify-content-center"
                >
                  <div class="spinner-border text-info" role="status"></div>
                </div>
                <div
                  v-else
                  v-for="appointment in appointments.confirmed"
                  :key="appointment?._id"
                >
                  <AppointmentCard :appointment="appointment" /></div
              ></el-tab-pane>
              <el-tab-pane label="Đã hoàn tất" name="third"
                ><div
                  v-if="isLoadingAppointment"
                  class="col-12 d-flex align-items-center justify-content-center"
                >
                  <div class="spinner-border text-info" role="status"></div>
                </div>
                <div
                  v-else
                  v-for="appointment in appointments.canceled"
                  :key="appointment?._id"
                >
                  <AppointmentCard :appointment="appointment" /></div
              ></el-tab-pane>
              <el-tab-pane label="Đã hủy" name="fourth"
                ><div
                  v-if="isLoadingAppointment"
                  class="col-12 d-flex align-items-center justify-content-center"
                >
                  <div class="spinner-border text-info" role="status"></div>
                </div>
                <div
                  v-else
                  v-for="appointment in appointments.finished"
                  :key="appointment?._id"
                >
                  <AppointmentCard :appointment="appointment" /></div
              ></el-tab-pane>
            </el-tabs>
          </div>
        </div>
      </div>
    </div>
  </GuestLayout>
</template>
<script lang="ts" src="./Appointment.ts"></script>
<style scoped lang="css" src="./style.css"></style>
