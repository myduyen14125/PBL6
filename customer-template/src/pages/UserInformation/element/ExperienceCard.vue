<template>
  <div>
    <div class="row py-2">
      <div class="col-md-9 d-flex">
        <img :src="coverImg" class="avatar mx-md-4" />
        <div>
          <p class="title mb-0">Chief Technology Officer</p>
          <p class="sub-title">Officer</p>
          <p class="content">
            - Manage and develop websites (https://mentori.vn;
            https://school.mentori.vn) and mobile application (Mentori)
            <br />
            - Research and support the development of reporting systems and data
            analysis to optimize business operations and user experience
          </p>
        </div>
      </div>
      <div class="col-md-3 text-end">
        <p>09/2019 - Hiện tại</p>
        <div class="d-flex align-items-center justify-content-end">
          <el-tooltip
            class="box-item"
            effect="light"
            content="Chỉnh sửa"
            placement="bottom"
          >
            <SvgIcon icon="edit" class="p-2 mr-2 bg-edit button" />
          </el-tooltip>
          <el-tooltip
            class="box-item"
            effect="light"
            content="Xóa"
            placement="bottom"
          >
            <SvgIcon icon="delete" class="p-2 bg-delete button" />
          </el-tooltip>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from "vue";
import SvgIcon from "../../../components/BUI/SvgIcon/SvgIcon.vue";
import coverImg from "../../../assets/image/cover.jpg";

export default {
  components: {
    SvgIcon,
  },
  setup() {
    return {
      coverImg,
    };
  },
};
</script>

<style scoped lang="css">
.avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  object-fit: cover;
  margin: 0px 10px;
}

.title {
  font-weight: 600;
}

.content {
  color: #555;
}

.bg-edit {
  background-color: #17a2b8;
}

.button {
  border-radius: 4px;
  cursor: pointer;
}

.bg-delete {
  background-color: #dc3545;
}

.a {
  background-color: red;
}
</style>
