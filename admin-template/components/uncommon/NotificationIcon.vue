<template>
  <div>
    <div 
      class="wrapper-noti d-flex justify-content-center align-items-center"
      :class="(isToggle && !isShowTitle) ? 'zoom-out' : 'zoom-in'"
    >
      <span class="">{{ count }}</span>
    </div>
  </div>
</template>
<script>
export default {
  props: {
    count: {
      type: Number,
      default: 0
    },
    isToggle: {
      type: Boolean,
      default: false
    },
    isShowTitle: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
    }
  },
  mounted() {
    console.log("count: ", this.count)
  }
}
</script>
<style lang="scss" scoped>
.wrapper-noti {
  position: relative;
  width: 18px;
  height: 18px;
  background-color: $color-red-2;
  border-radius: 50%;
  z-index: 10;
  span {
    color: $color-white;
    font-size: 10px;
  }
}
.zoom-in {
  top: 1px;
}
.zoom-out {
  top: -10px;
  left: -22px;
}
</style>