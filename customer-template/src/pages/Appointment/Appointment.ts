import { defineComponent, onMounted, ref, Ref } from "vue";
import GuestLayout from "../../layout/GuestLayout/GuestLayout.vue";
import AppointmentCard from "../../components/AppointmentCard/AppointmentCard.vue";
import { useAppointment } from "../../stores/appointment";
import SwalPopup from "../../ultils/swalPopup";
import { Appointment } from "../../types/appointment";
import ConfirmModal from "../../components/AppointmentCard/ConfirmModal/ConfirmModal.vue";
import { GetPaginationParams } from "../../types/mentor";

interface AllAppointment {
  pending: Appointment[];
  confirmed: Appointment[];
  canceled: Appointment[];
  finished: Appointment[];
}

export default defineComponent({
  name: "Appointment",
  components: { GuestLayout, AppointmentCard, ConfirmModal },
  setup() {
    const appointmentsStore = useAppointment();
    const isLoadingAppointment = ref(false);
    const activeName = ref("pending");
    const appointments = ref<AllAppointment>({
      pending: [],
      confirmed: [],
      canceled: [],
      finished: [],
    });
    const selectedAppointment = ref();
    const totalPage = ref(0);
    const paging = ref(0);
    const pagination = ref({
      page: 1,
      limit: 6,
      countPage: 0,
      count: 0
    })

    const handleClick = (tab: any, event: any) => {
      // console.log(tab, event);
    };
    const confirmModal: Ref<any> = ref<typeof ConfirmModal | null>(null);

    onMounted(() => {
      getAllUserAppointment();
    });

    const resetAppointments = () => {
      appointments.value = {
        pending: [],
        confirmed: [],
        canceled: [],
        finished: [],
      };
    };

    const getAllUserAppointment = () => {
      resetAppointments();
      isLoadingAppointment.value = true;
      appointmentsStore.requestGetAllUserAppointment({
        params: {
          page: 1,
          limit: 100,
        } as GetPaginationParams,
        callback: {
          onSuccess: (res) => {
            console.log(res)
            pagination.value.count = res.count;
            pagination.value.countPage = res.countPage;
            res.appointments.map((appointment: Appointment) => {
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

    const onChangeAppointmentStatus = (status: string) => {
      activeName.value = status;
      getAllUserAppointment();
    };

    const showAppointmentDetail = (appointment: Appointment) => {
      selectedAppointment.value = appointment;
      confirmModal?.value?.show();
    };

    return {
      confirmModal,
      activeName,
      handleClick,
      isLoadingAppointment,
      selectedAppointment,
      appointments,
      getAllUserAppointment,
      onChangeAppointmentStatus,
      showAppointmentDetail,
      pagination
    };
  },
});
