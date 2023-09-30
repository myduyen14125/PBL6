export const actions = {
  async fetchList({ commit, state }) {
    const { data } = await this.$axios.get('/contacts/subjects')
    commit('setSubject', data.data)
  }
}
