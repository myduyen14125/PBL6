<template>
  <div>
    <div class="table-header d-flex align-items-center justify-content-between mb-4">
      <h1 class="title">Create new contact</h1>
      <button class="btn-custom btn-white" @click="$router.go(-1)">
        Cancel
      </button>
    </div>
    <FormContact :subjects="subjectList"/>
  </div>
</template>
<script>
import { mapActions, mapGetters } from 'vuex';
import FormContact from '~/components/form/FormContact.vue';

export default {
  name: 'Contact',
  components: {
    FormContact
  },
  layout: 'secret',
  computed: {
    ...mapGetters({
      subjectList: 'subject/getSubjects'
    })
  },
  created() {
    this.fetchSubjectList();
  },
  methods: {
    ...mapActions({
      fetchSubjectList: 'subject/fetchList'
    }),
    getSubjectName(id) {
      const subject = this.subjectList.find(item => item.id === id);
      return subject ? subject.title : '-';
    }
  }
}
</script>
<style lang="scss" scoped>

</style>