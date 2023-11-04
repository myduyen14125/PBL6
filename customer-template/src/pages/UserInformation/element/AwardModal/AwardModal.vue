<template>
  <BModal
    v-model:modal="modal"
    id="experience_modal"
    title="Thêm quá trình học tập"
    size="lg"
    animation="fade"
    :noCloseOnBackdrop="true"
  >
    <template v-slot:body>
      <form>
        <div className="form-group required mb-3">
          <p class="label">Tên giải thưởng</p>
          <input
            type="text"
            v-model="form.name"
            name="place"
            :className="
              ['form-control', error.name ? 'is-invalid' : '']
                .filter(Boolean)
                .join(' ')
            "
            placeholder="Nhập tên trường học"
            @blur="validateRequired('name')"
          />
          <p v-if="error.name" class="error-message mt-1">
            {{ error.name }}
          </p>
        </div>
        <div className="form-group required mb-3">
          <p class="label">Mô tả</p>
          <textarea
            rows="4"
            v-model="form.description"
            name="description"
            :className="
              ['form-control', error.description ? 'is-invalid' : '']
                .filter(Boolean)
                .join(' ')
            "
            placeholder="Nhập mô tả chi tiết (Điểm số hoặc thành tích)"
            @blur="validateRequired('description')"
          />
          <p v-if="error.description" class="error-message mt-1">
            {{ error.description }}
          </p>
        </div>
        <div className="form-group required mb-3">
          <p class="label">Thời gian nhận giải thưởng</p>
          <el-date-picker
            :class="
              ['w-100', error.date ? 'is-valid' : ''].filter(Boolean).join(' ')
            "
            v-model="form.date"
            type="date"
            range-separator="đến"
            format="DD/MM/YYYY"
            value-format="YYYY-MM-DD"
            @blur="validateRequired('date')"
          />
          <p v-if="error.date" class="error-message mt-1">{{ error.date }}</p>
        </div>
      </form>
    </template>
    <template v-slot:footer>
      <BButton
        typeButton="submit"
        classes="btn btn-primary px-5"
        label="Lưu"
        @click="submitForm"
        :isLoading="isSubmitting"
      />
    </template>
  </BModal>
</template>
<script lang="ts" src="./AwardModal.ts"></script>
<style scoped lang="scss" src="./style.css"></style>
