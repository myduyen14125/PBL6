<template>
  <GuestLayout>
    <div class="appointment-wrapper">
      <div class="container py-20 text-lg min-h-[65vh]">
        <div class="row">
          <div class="col-3 col-md-3">
            <SvgIcon icon="calendarFull" />
          </div>
          <div class="col-md-12 col-lg-9">
            <h1 class="text-left font-bold text-4xl mb-4">Lịch hẹn của tôi</h1>
            <el-tabs v-model="activeName" @tab-click="handleClick">
              <el-tab-pane label="Đang xử lý" name="pending">
                <div v-if="isLoadingAppointment" class="col-12 d-flex align-items-center justify-content-center">
                  <div class="spinner-border text-info" role="status"></div>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-4" v-else>
                  <p class="text-lg font-medium" v-if="appointments.pending.length == 0">
                    Hiện không có lịch hẹn nào.
                  </p>
                  <AppointmentCard 
                    v-else 
                    v-for="appointment in appointments.pending" 
                    :key="appointment?._id"
                    :appointment="appointment" 
                    @getAllUserAppointment="onChangeAppointmentStatus"
                    @click="() => showAppointmentDetail(appointment)" />
                </div>
              </el-tab-pane>
              <el-tab-pane label="Đã xác nhận" name="confirmed">
                <div v-if="isLoadingAppointment" class="col-12 d-flex align-items-center justify-content-center">
                  <div class="spinner-border text-info" role="status"></div>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-4" v-else>
                  <p class="text-lg font-medium" v-if="appointments.confirmed.length == 0">
                    Hiện không có lịch hẹn nào.
                  </p>
                  <AppointmentCard 
                    v-else v-for="appointment in appointments.confirmed" 
                    :key="appointment?._id"
                    :appointment="appointment" 
                    @getAllUserAppointment="onChangeAppointmentStatus"
                    @click="() => showAppointmentDetail(appointment)" />
                </div>
              </el-tab-pane>
              <el-tab-pane label="Đã hoàn tất" name="finished">
                <div v-if="isLoadingAppointment" class="col-12 d-flex align-items-center justify-content-center">
                  <div class="spinner-border text-info" role="status"></div>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-4" v-else>
                  <p class="text-lg font-medium" v-if="appointments.finished.length == 0">
                    Hiện không có lịch hẹn nào.
                  </p>
                  <AppointmentCard 
                    v-else 
                    v-for="appointment in appointments.finished" 
                    :key="appointment?._id"
                    :appointment="appointment" 
                    @getAllUserAppointment="onChangeAppointmentStatus"
                    @click="() => showAppointmentDetail(appointment)" />
                </div>
              </el-tab-pane>
              <el-tab-pane label="Đã hủy" name="canceled">
                <div v-if="isLoadingAppointment" class="col-12 d-flex align-items-center justify-content-center">
                  <div class="spinner-border text-info" role="status"></div>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-4" v-else>
                  <p class="text-lg font-medium" v-if="appointments.canceled.length == 0">
                    Hiện không có lịch hẹn nào.
                  </p>
                  <AppointmentCard 
                    v-else 
                    v-for="appointment in appointments.canceled" 
                    :key="appointment?._id"
                    :appointment="appointment" 
                    @getAllUserAppointment="onChangeAppointmentStatus"
                    @click="() => showAppointmentDetail(appointment)" />
                </div>
              </el-tab-pane>
            </el-tabs>
            <div class="my-5 d-flex">
              <!-- <el-pagination
                class="ms-auto"
                v-model:current-page="pagination.page"
                :page-size="pagination.limit"
                background
                layout="prev, pager, next"
                :total="pagination.count"
                @current-change="getAllUserAppointment"
              /> -->
            </div>
          </div>
        </div>
      </div>
    </div>
    <ConfirmModal ref="confirmModal" :appointment="selectedAppointment" @cancel="() => { }" @confirm="() => { }" />
  </GuestLayout>
</template>
<script lang="ts" src="./Appointment.ts"></script>
<style scoped lang="css" src="./style.css"></style>
