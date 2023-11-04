import { ref, defineComponent, Ref } from "vue";
import SvgIcon from "../../../../components/BUI/SvgIcon/SvgIcon.vue";
import coverImg from "../../../../assets/image/cover.jpg";
import { PropType } from "vue";
import { formatDate } from "../../../../ultils/date";
import { useBio } from "../../../../stores/bio";
import SwalPopup from "../../../../ultils/swalPopup";
import ExperienceModal from "../ExperienceModal/ExperienceModal.vue";

export default defineComponent({
  name: "ExperienceCard",
  components: {
    SvgIcon,
    ExperienceModal,
  },
  emits: ["updatedCard"],
  props: {
    showEdit: {
      type: Boolean,
      required: false,
      default: false,
    },
    data: {
      type: Object as PropType<any>,
      required: true,
      default: () => ({}),
    },
    type: {
      type: String,
    },
    bio: {
      type: String,
      required: false,
      default: "",
    },
  },
  setup(props, { emit }) {
    const bioStore = useBio();
    const isSubmitting = ref(false);
    const experienceModal: Ref<any> = ref<typeof ExperienceModal | null>(null);

    const updated = () => {
      emit("updatedCard", 1);
    };

    const toggleEdit = (): void => {
      if (props?.type == "experience") {
        experienceModal?.value?.show();
      }
    };

    const onDelete = () => {
      SwalPopup.swalDeletePopup(
        "",
        {
          onConfirmed: () => {
            if (props?.type == "experience") {
              deleteExperience(props?.data?._id);
            }
          },
        },
        {
          html: "Bạn có chắc chắn xóa ?",
        }
      );
    };

    const deleteExperience = (id: string) => {
      isSubmitting.value = true;
      bioStore.requestDeleteExperience({
        id,
        callback: {
          onSuccess: (res) => {
            isSubmitting.value = false;
            updated();
          },
          onFailure: () => {
            SwalPopup.swalResultPopup(
              "Sorry, looks like there are some errors detected, please try again.",
              "error"
            );
            isSubmitting.value = false;
          },
        },
      });
    };

    return {
      coverImg,
      experienceModal,
      updated,
      onDelete,
      formatDate,
      toggleEdit,
    };
  },
});
