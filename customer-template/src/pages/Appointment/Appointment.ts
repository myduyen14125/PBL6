import { defineComponent } from "vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import AppointmentCard from "../../components/AppointmentCard/AppointmentCard.vue";


export default defineComponent({
  name: "Appointment",
  components: { GuestLayout, AppointmentCard},
  setup() {
    const handleClick = (tab: any, event: any) => {
      console.log(tab, event);
    }
    return {
      activeName: "first",
      handleClick,
    };
  },
});
