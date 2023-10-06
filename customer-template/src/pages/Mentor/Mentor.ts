import { defineComponent } from 'vue'
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import MentorCard from "../../components/MentorCard/MentorCard.vue";
import SearchBar from "./element/SearchBar.vue"

export default defineComponent({
  name: 'Mentor',
  components: { GuestLayout, MentorCard, SearchBar },
  setup() {
    const mentors = [
      {
        name: "Tran Thi Nga",
        description: "Sinh viên tại DUT University. ",
        avatar: "https://khoinguonsangtao.vn/wp-content/uploads/2022/08/hinh-anh-anime-nu-1.jpg",
        numberOfMentees: 12,
        numberOfLikes: 100,
        freeTime: "14:30, Monday"
      },
      {
        name: "Yuu nee",
        description: "Sinh viên tại DUT University. ",
        avatar: "https://khoinguonsangtao.vn/wp-content/uploads/2022/08/hinh-anh-anime-nu-1.jpg",
        numberOfMentees: 12,
        numberOfLikes: 100,
        freeTime: "14:30, Mon"
      },
      {
        name: "Le Ngoc Hung",
        description: "Sinh viên tại DUT University. ",
        avatar: "https://khoinguonsangtao.vn/wp-content/uploads/2022/08/hinh-anh-anime-nu-1.jpg",
        numberOfMentees: 12,
        numberOfLikes: 100,
        freeTime: "14:30, Mon"
      },
      {
        name: "Phan Tien Dat",
        description: "Sinh viên tại DUT University. ",
        avatar: "https://khoinguonsangtao.vn/wp-content/uploads/2022/08/hinh-anh-anime-nu-1.jpg",
        numberOfMentees: 12,
        numberOfLikes: 100,
        freeTime: "14:30, Mon"
      },
      {
        name: "Thoa Truong",
        description: "Sinh viên tại DUT University. ",
        avatar: "https://khoinguonsangtao.vn/wp-content/uploads/2022/08/hinh-anh-anime-nu-1.jpg",
        numberOfMentees: 12,
        numberOfLikes: 100,
        freeTime: "14:30, Mon"
      },
      {
        name: "Mentor 6",
        description: "Sinh viên tại DUT University. ",
        avatar: "https://khoinguonsangtao.vn/wp-content/uploads/2022/08/hinh-anh-anime-nu-1.jpg",
        numberOfMentees: 12,
        numberOfLikes: 100,
        freeTime: "14:30, Mon"
      }
    ]
    return {
      mentors
    }
  },
})