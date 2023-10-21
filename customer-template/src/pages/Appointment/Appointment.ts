import { defineComponent, onMounted, ref, computed } from "vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import AppointmentCard from "../../components/AppointmentCard/AppointmentCard.vue";
import { useAppointment } from "../../stores/appointment";
import SwalPopup from "../../ultils/swalPopup";
import { Appointment } from "../../types/appointment";

interface AllAppointment {
  pending: Appointment[];
  confirmed: Appointment[];
  canceled: Appointment[];
  finished: Appointment[];
}

export default defineComponent({
  name: "Appointment",
  components: { GuestLayout, AppointmentCard },
  setup() {
    const appointmentsStore = useAppointment();
    const isLoadingAppointment = ref(false);
    const appointments = ref<AllAppointment>({
      pending: [],
      confirmed: [],
      canceled: [],
      finished: [],
    });
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
            res.map((appointment: Appointment) => {
              if (appointment?.status == "pending") {
                appointments.value.pending.push(appointment);
              } else if (appointment?.status == "confirmed") {
                appointments.value.confirmed.push(appointment);
              } else if (appointment?.status == "canceled") {
                appointments.value.canceled.push(appointment);
              } else {
                appointments.value.finished.push(appointment);
              }
            });
            isLoadingAppointment.value = false;
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
    };
  },
});
