<template>
  <BModal
    class="experience_modal"
    v-model:modal="modal"
    id="experience_modal"
    :title="
      data ? 'Chỉnh sửa kinh nghiệm làm việc' : 'Thêm kinh nghiệm làm việc'
    "
    size="lg"
    animation="fade"
    :noCloseOnBackdrop="true"
  >
    <template v-slot:body>
      <form>
        <div className="form-group required mb-3">
          <p class="label">Tên công ty</p>
          <input
            data-test-id="input-company"
            type="text"
            v-model="form.company"
            name="company"
            :className="
              ['form-control', error.company ? 'is-invalid' : '']
                .filter(Boolean)
                .join(' ')
            "
            placeholder="Nhập tên công ty"
            @blur="validateRequired('company')"
          />
          <p v-if="error.company" class="error-message mt-1">
            {{ error.company }}
          </p>
        </div>
        <div className="form-group required mb-3">
          <p class="label">Vị trí</p>
          <input
            data-test-id="input-position"
            type="text"
            v-model="form.position"
            name="position"
            :className="
              ['form-control', error.position ? 'is-invalid' : '']
                .filter(Boolean)
                .join(' ')
            "
            placeholder="Nhập vị trí"
            @blur="validateRequired('position')"
          />
          <p v-if="error.position" class="error-message mt-1">
            {{ error.position }}
          </p>
        </div>
        <div className="form-group required mb-3">
          <p class="label">Mô tả</p>
          <textarea
            rows="4"
            data-test-id="input-description"
            v-model="form.description"
            name="description"
            :className="
              ['form-control', error.description ? 'is-invalid' : '']
                .filter(Boolean)
                .join(' ')
            "
            placeholder="Nhập mô tả chi tiết (Trải nghiệm/ Thành tích nổi bật)"
            @blur="validateRequired('description')"
          />
          <p v-if="error.description" class="error-message mt-1">
            {{ error.description }}
          </p>
        </div>
        <div className="form-group required mb-3">
          <p class="label">Thời gian</p>
          <el-date-picker
            data-test-id="input-date"
            :class="
              ['w-100', error.date ? 'is-valid' : ''].filter(Boolean).join(' ')
            "
            v-model="form.date"
            type="daterange"
            range-separator="đến"
            start-placeholder="DD/MM/YYYY"
            end-placeholder="DD/MM/YYYY"
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
        data-test-id="experience-submit-btn"
        typeButton="submit"
        classes="btn btn-primary px-5"
        label="Lưu"
        @click="submitForm"
        :isLoading="isSubmitting"
      />
    </template>
  </BModal>
</template>
<script lang="ts" src="./ExperienceModal.ts"></script>
<style scoped lang="scss" src="./style.css"></style>
