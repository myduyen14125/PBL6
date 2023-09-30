<template>
  <div v-if="visible" class="modal-wrapper">
    <div class="modal-container">
      <div class="modal-content">
        <h2 class="modal-title color-primary mb-4">{{ title }}</h2>
        <p class="modal-description color-primary">{{ description }}</p>
        <div class="modal-buttons d-flex justify-content-center align-items-center w-100 mt-4">
          <button class="btn-custom btn-white mr-3" @click="cancel">Cancel</button>
          <button class="btn-custom btn-blue" @click="functionAction">{{ functionText }}</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    title: {
      type: String,
      required: true
    },
    description: {
      type: String,
      required: true
    },
    functionText: {
      type: String,
      required: true
    },
  },
  data() {
    return {
      visible: true
    };
  },
  methods: {
    cancel() {
      this.visible = false
      this.$emit('close')
    },
    functionAction() {
      this.$emit('function-action')
    }
  }
};
</script>

<style scoped lang="scss">
.modal-wrapper {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.6);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 100;
}

.modal-container {
  max-width: 600px;
  width: 426px;
  height: 230px;
  background-color: $color-white;
  border-radius: 16px;
  overflow: hidden;
}

.modal-content {
  padding: 40px 24px;
}

.modal-title {
  font-weight: 500;
  font-size: 24px;
}

.modal-description {
  font-weight: 400;
  font-size: 16px;
}

.btn-modal-function {
  background-color: $color-blue;
  color: $color-white;
  border: none;
  padding: 8px 12px;
  border-radius: 4px;
  cursor: pointer;
}
</style>
