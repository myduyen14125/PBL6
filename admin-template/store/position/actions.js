export const actions = {
  async fetchList({ commit, state }) {
    const { data } = await this.$axios.get('/applications/positions')
    commit('setPosition', data.data)
  }
}
