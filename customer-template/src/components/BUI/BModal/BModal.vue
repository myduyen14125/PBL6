<template>
  <div
    ref="newTargetModalRef"
    class="modal"
    v-bind:id="id"
    tabindex="-1"
    role="dialog"
    aria-hidden="true"
    :class="{ [`${animation}`]: true }"
  >
    <div
      class="modal-y modal-dialog modal-dialog-centered modal-dialog-scrollable"
      role="document"
      :class="{ [`modal-${size}`]: true }"
    >
      <div class="modal-content">
        <div v-if="$slots.header" class="modal-header">
          <slot name="header" />
        </div>
        <div v-else class="modal-header">
          <div class="d-flex align-items-center w-100">
            <h5 class="modal-title">{{ title }}</h5>
            <span class="cursor-pointer ml-auto" @click="hide">
              <SvgIcon icon="closeModal" />
            </span>
          </div>
        </div>
        <div class="modal-body">
          <slot name="body" />
        </div>
        <div
          v-if="$slots.footer"
          class="modal-footer d-flex align-items-center"
        >
          <slot name="footer" :close="hide" />
        </div>
      </div>
    </div>
  </div>
</template>
<script lang="ts" src="./BModal.ts"></script>
<style scoped lang="css" src="./style.css"></style>
