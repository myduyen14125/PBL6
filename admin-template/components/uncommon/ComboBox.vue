<template>
  <div class="select-wrapper position-relative">
    <v-select 
      v-model="selectedOption" 
      class="style-chooser" 
      label="title"
      :placeholder="$attrs.placeholder || 'Select'" 
      :searchable="false"
      :options="optionsWithAllOption" 
      @input="handleSelectionChange"
    />
  </div>
</template>

<script>
export default {
  name: "SelectInput",
  props: {
    optionsProp: {
      type: Array,
      required: true
    }
  },
  data() {
    return {
      selectedOption: null,
    };
  },
  computed: {
    optionsWithAllOption() {
      const allOption = { id: "", title: "All" };
      return [allOption, ...this.optionsProp];
    }
  },
  methods: {
    handleSelectionChange() {
      this.$emit("selection-change", this.selectedOption.id);
    }
  }
};
</script>


<style lang="scss" scoped>
.select-wrapper {
  display: inline-block;
  position: relative;
}
.style-chooser :deep(.vs__dropdown-toggle) {
  height: 32px;
  border-radius: 8px;
  width: 230px;
  border: 1px solid $color-blue;
}
.style-chooser :deep(.vs__dropdown-menu) {
  top: 44px;
  border-radius: 8px;
  width: 230px;
}
.style-chooser :deep(.vs__dropdown-option) {
  height: 41px;
}
:deep(.vs--single) {
  transition: 0s;
  &:not(.vs--open) .vs__selected + .vs__search {
    // force this to not use any space
    // we still need it to be rendered for the focus
    width: 0;
    padding: 0;
    margin: 0;
    border: none;
    height: 0;
    transition: 0s; // for not rolling top down
  }
  .vs--open {
    position: static !important;
    transition: 0s;
  }

  .vs__selected-options {
    // do not allow growing
    width: 0;
  }

  .vs__selected {
    display: block;
    white-space: nowrap;
    text-overflow: ellipsis;
    max-width: 100%;
    overflow: hidden;
  }
}

input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}
</style>
