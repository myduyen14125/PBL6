import { defineComponent, onMounted, ref, computed } from "vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import AppointmentCard from "../../components/AppointmentCard/AppointmentCard.vue";
import { useAppointment } from "../../stores/appointment";
import SwalPopup from "../../ultils/swalPopup";
import { Appointment } from "../../types/appointment";
import { formatDate } from "../../ultils/date";

export default defineComponent({
  name: "Appointment",
  components: { GuestLayout, AppointmentCard },
  setup() {
    const appointmentsStore = useAppointment();
    const isLoadingAppointment = ref(false);
    const appointments = ref<Appointment[]>([]);
    const handleClick = (tab: any, event: any) => {
      console.log(tab, event);
    };

    onMounted(() => {
      getAllUserAppointment();
    });

    const getAllUserAppointment = () => {
      isLoadingAppointment.value = true;
      appointmentsStore.requestGetAllUserAppointment({
        callback: {
          onSuccess: (res) => {
            appointments.value = res;
            isLoadingAppointment.value = false;
            console.log(appointments.value);
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
            isLoadingAppointment.value = false;
          },
        },
      });
    };

    return {
      activeName: "first",
      handleClick,
      isLoadingAppointment,
      appointments,
      formatDate,
    };
  },
});
