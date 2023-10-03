<template>
  <Header></Header>
  <div class="content-wrapper">
    <div v-if="$slots.header" class="content-header">
      <div class="container-fluid">
        <slot name="header" />
      </div>
    </div>
    <div class="content">
      <div class="container-fluid">
        <RouterView></RouterView>
      </div>
    </div>
  </div>
</template>
<script lang="ts" src="./GuestLayout.ts"></script>
