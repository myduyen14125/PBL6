// axios1: attact token
// axios2: no token
export default (axios1, axios2) => ({
  getListNewsCate: async () => {
    return await axios1.get(`/news/categories`)
  },
  getNewsCateById: async (id) => {
    return await axios1.get(`/news/categories/${id}`)
  },
  createNewsCate: async (data) => {
    return await axios1.post(`/news/categories`, data)
  },
  updateNewsCate: async (id, data) => {
    return await axios1.put(`/news/categories/${id}`, data)
  },
  deleteNewsCate: async (id) => {
    return await axios1.delete(`/news/categories/${id}`)
  }
})