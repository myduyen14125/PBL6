<template>
  <div class="search-wrapper w-fit rounded py-2">
    <div class="search-bar flex flex-wrap items-center">
      <div class="search-location my-2 me-4 relative">
        <button
          @click="toggleLocationSelector"
          class="btn-location h-12 flex items-center space-x-2 pl-3 rounded-lg bg-gray-100 w-56 focus:outline-none hover:outline-none"
        >
          <SvgIcon icon="locationIcon" />
          <span class="pl-3 inline-block text-center">{{
            chosenExpertise?.name || "Chọn lĩnh vực"
          }}</span>
        </button>

        <div
          v-if="showLocationSelector"
          class="absolute z-10 top-14 left-0 w-56 bg-white shadow-lg rounded-lg"
        >
          <ul class="p-0">
            <li
              class="py-2 px-8 hover:bg-gray-100 cursor-pointer rounded-lg"
              v-for="expertise in listExpertise"
              :key="expertise._id"
              @click="selectExpertise(expertise)"
            >
              {{ expertise?.name }}
            </li>
          </ul>
        </div>
      </div>
      <div class="search-input my-2 relative">
        <input
          type="text"
          v-model="searchText"
          placeholder="Tìm kiếm mentor hoặc lĩnh vực mong muốn"
          class="w-[350px] h-12 px-3 py-2 rounded-lg border-0 focus:outline-none"
          @focus="showMajorDropdown = true"
          @blur="showMajorDropdown = false"
          @keydown.enter="onSearchMentor"
        />
        <div class="absolute inset-y-0 right-0 flex items-center pr-4">
          <SvgIcon
            icon="searchIcon"
            class="cursor-pointer"
            @click="onSearchMentor"
          />
        </div>
        <!-- <div
          v-if="showMajorDropdown"
          class="absolute z-10 top-full left-0 w-[400px] bg-white shadow-lg mt-2 rounded-lg"
        >
          <div class="major-wrapper">
            <h4 class="text-lg font-bold pl-4 py-2 bg-slate-100 rounded-t-lg">
              Chuyên ngành
            </h4>
            <ul class="p-0 flex flex-wrap mx-4">
              <li
                class="w-40 py-2 pl-3 hover:bg-gray-100 cursor-pointer rounded"
                v-for="(item, index) in positions"
                :key="index"
                @click="selectPosition(item)"
              >
                {{ item }}
              </li>
            </ul>
          </div>
          <div class="position-wrapper">
            <h4 class="text-lg font-bold pl-4 py-2 bg-slate-100">Vị trí</h4>
            <ul class="p-0 flex flex-wrap mx-4">
              <li
                class="w-40 py-2 pl-3 hover:bg-gray-100 cursor-pointer rounded"
                v-for="(item, index) in positions"
                :key="index"
                @click="selectPosition(item)"
              >
                {{ item }}
              </li>
            </ul>
          </div>
        </div> -->
      </div>
    </div>
  </div>
</template>

<script lang="ts" src="./SearchBar.ts"></script>
<style scoped lang="css" src="./style.css"></style>
