<template>
  <button
    :type="typeButton"
    class="btn"
    :class="{ [`${classes}`]: true }"
    :disabled="isLoading"
    @click="onClick"
  >
    <span
      v-if="isLoading"
      class="spinner-border spinner-border-sm mr-2"
      role="status"
      aria-hidden="true"
    />
    <slot v-if="$slots.innerHTML" name="innerHTML" />
    <span v-else>{{
      labelIsLoading && isLoading ? labelIsLoading : label
    }}</span>
  </button>
</template>
<script lang="ts" src="./BButton.ts"></script>
