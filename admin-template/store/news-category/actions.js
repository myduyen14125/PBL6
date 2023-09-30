export const actions = {
  async fetchList({ commit, state }) {
    const { data } = await this.$axios.get('/news/categories')
    commit('setCategory', data.data)
  }
}
