<template>
  <div @mouseover="changeMouseOver(true)" @mouseleave="changeMouseOver(false)">
    <client-only>
      <ValidationObserver>
        <ValidationProvider
          v-slot="{ errors }"
          rules="required|noSpaces|max:20000"
          name="content detail"
        >
          <quill-editor
            ref="editor"
            v-model.lazy="editedContent"
            :options="editorOption"
            class="editor--border relative"
            :disabled="!isMouseOver"
            :autofocus="false"
            @change="debounceTextChange"
          />
          <span class="text-danger __label validate-text">{{ errors[0] }}</span>
        </ValidationProvider>
      </ValidationObserver>
    </client-only>
  </div>
</template>
<script>
import { debounce } from "vue-debounce";
import { ValidationObserver, ValidationProvider } from "vee-validate";
export default {
  components: {
    ValidationObserver,
    ValidationProvider,
  },
  props: {
    content: {
      type: String,
      default: "",
    },
  },
  data() {
    return {
      // All text editor function settings are written in editorOption
      editorOption: {
        theme: "snow",
        modules: {
          toolbar: {
            container: [
              // ['bold', 'italic', 'underline', 'strike', 'code'],
              ["bold", "italic", "underline"],
              ["blockquote", "code-block"],
              [{ header: [false, 1, 2, 3, 4] }],
              [{ list: "ordered" }, { list: "bullet" }],
              // [{ script: 'sub' }, { script: 'super' }],
              [{ indent: "-1" }, { indent: "+1" }],
              [{ size: ["small", false, "large", "huge"] }],
              [{ color: [] }, { background: [] }],
              [{ align: [] }],
              // ['clean'],
              ["image", "link"],
            ],
            // customize image upload function
            handlers: {
              image: this.uploadFunction,
            },
          },
        },
      },
      hasSpaces: false,
      isMouseOver: false,
    };
  },
  // The issue might be related to the timing of when the content prop is passed down to the child component and when the child component's data object is set.
  computed: {
    editedContent: {
      get() {
        return this.content;
      },
      set(value) {
        this.$emit("input", value);
      },
    },
  },
  watch: {
    hasSpaces(newVal) {
      this.$emit("has-spaces", newVal);
    },
  },
  methods: {
    debounceTextChange: debounce(function (content) {
      // console.log('Content debounce: ', this.editedContent)
      if (this.checkSpacesBetweenHtmlTag(this.editedContent)) {
        // console.log("spacessss ")
        this.hasSpaces = true;
      } else {
        // console.log("no spacessss ")
        this.hasSpaces = false;
      }
      this.$emit("text-change", this.editedContent);
      this.$emit("has-spaces", this.hasSpaces);
    }, 500),
    uploadFunction() {
      // create a new file input element
      const input = document.createElement("input");
      input.setAttribute("type", "file");
      input.setAttribute("accept", "image/*");
      // input.setAttribute('style', 'display:none')
      // add event listener to capture the selected file
      input.addEventListener("change", () => {
        // read the file and convert it to a data URL
        const file = input.files[0];
        const reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = async () => {
          const url = await this.uploadImage(file);
          // insert the image into the editor
          const range = this.$refs.editor.quill.getSelection();
          this.$refs.editor.quill.insertEmbed(range.index, "image", url);
        };
      });
      // trigger a click event on the input element
      document.body.appendChild(input);
      input.click();
      document.body.removeChild(input);
    },
    async uploadImage(file) {
      // console.log("file", file)
      const formData = new FormData();
      formData.append("file", file);
      const response = await this.uploadFile(formData);
      // console.log("response", response)
      return response;
    },
    uploadFile(data) {
      // console.log("formData", data)
      return this.$api.upload
        .uploadFile(data)
        .then((res) => {
          return res.data.data;
        })
        .catch((error) => {
          // console.error("Error in uploadFile()", error)
          throw error;
        });
    },
    checkSpacesBetweenHtmlTag(string) {
      const regexSplitPair = /(<.*?>)([\s\S]*?)(<\/.*?>)/g;
      const tagPairs = string.match(regexSplitPair);
      for (let i = 0; i < tagPairs.length; i++) {
        const regexSpaceInside = /<.*>(\s*)<\/.*>/g;
        if (!regexSpaceInside.test(tagPairs[i])) {
          // console.error(tagPairs[i], "false");
          return false;
        }
      }
      return true;
    },
    changeMouseOver(value) {
      this.isMouseOver = value;
    },
  },
};
</script>
<style lang="scss" scoped>
.quill-editor {
  // width: 780px;
  min-height: 200px;
  max-height: 65vh;
  // overflow-y: auto;
  // max-height: 375px;
  :deep(.ql-toolbar) {
    position: sticky;
    top: 0;
    left: 0;
    background-color: $color-white;
    z-index: 10;
  }
  :deep(.ql-editor) {
    min-height: 200px !important;
    max-height: 350px !important;
    font-size: 1rem;
    color: $color-secondary;
  }
}
.editor--border {
  border: 1px solid $color-gray-lighter;
}
</style>
