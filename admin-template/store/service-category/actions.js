export const actions = {
  async fetchList({ commit, state }) {
    const { data } = await this.$axios.get('/services/categories')
    commit('setCategory', data.data)
  }
}
