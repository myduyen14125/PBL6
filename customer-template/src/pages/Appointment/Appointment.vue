<template>
  <GuestLayout>
    <div class="appointment-wrapper">
      <div class="container py-20 text-lg">
        <div class="row">
          <div class="col-4 col-md-3">
            <SvgIcon icon="calendarFull" />
          </div>
          <div class="col-md-12 col-lg-8">
            <h1 class="text-left font-bold text-4xl mb-4">Lịch hẹn của tôi</h1>
            <el-tabs v-model="activeName" @tab-click="handleClick">
              <el-tab-pane label="Đang xử lý" name="first">
                <div class="flex flex-wrap gap-4 list-card">
                  <div v-for="n in 6" key="n">
                    <AppointmentCard />
                  </div>
                </div>
              </el-tab-pane>
              <el-tab-pane label="Đã xác nhận" name="second">Config</el-tab-pane>
              <el-tab-pane label="Đã hoàn tất" name="third">Role</el-tab-pane>
              <el-tab-pane label="Đã hủy" name="fourth">Task</el-tab-pane>
            </el-tabs>
          </div>
        </div>
        
      </div>
    </div>
  </GuestLayout>
</template>
<script lang="ts" src="./Appointment.ts"></script>
<style scoped lang="css" src="./style.css"></style>