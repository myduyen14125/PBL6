// axios1: attact token
// axios2: no token
export default (axios1, axios2) => ({
  getListCategory: async () => {
    return await axios1.get(`/services/categories`)
  },
  getCategoryById: async (id) => {
    return await axios1.get(`/services/categories/${id}`)
  },
  createCategory: async (data) => {
    return await axios1.post(`/services/categories`, data)
  },
  updateCategory: async (id, data) => {
    return await axios1.put(`/services/categories/${id}`, data)
  },
  deleteCategory: async (id) => {
    return await axios1.delete(`/services/categories/${id}`)
  }
})