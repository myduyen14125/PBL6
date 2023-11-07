<template>
  <BModal
    v-model:modal="modal"
    id="experience_modal"
    title="Thêm kỹ năng hoặc chứng chỉ"
    size="lg"
    animation="fade"
    :noCloseOnBackdrop="true"
  >
    <template v-slot:body>
      <form>
        <div className="form-group required mb-3">
          <p class="label">Tên kỹ năng hoặc chứng chỉ</p>
          <input
            type="text"
            v-model="form.name"
            name="place"
            :className="
              ['form-control', error.name ? 'is-invalid' : '']
                .filter(Boolean)
                .join(' ')
            "
            placeholder="Nhập tên kỹ năng hoặc chứng chỉ"
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
            placeholder="Nhập mô tả chi tiết (Trải nghiệm/ Thành tích nổi bật)"
            @blur="validateRequired('description')"
          />
          <p v-if="error.description" class="error-message mt-1">
            {{ error.description }}
          </p>
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
<script lang="ts" src="./SkillModal.ts"></script>
