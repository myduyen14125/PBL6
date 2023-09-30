// axios1: attact token
// axios2: no token
export default (axios1, axios2) => ({
  getListProduct: async (queryObj = {}) => {
    const { page = 1, paging = 10, content = ''} = queryObj
    return await axios1.get(`/products/dashboard?page=${page}&paging=${paging}&content=${content ?? ""}`)
  },
  getProductById: async (id) => {
    return await axios1.get(`/products/dashboard/${id}`)
  },
  markPublicProduct: async (id) => {
    return await axios1.patch(`/products/dashboard/${id}/public`)
  },
  createProduct: async (data) => {
    return await axios1.post(`/products/dashboard`, data)
  },
  updateProduct: async (id, data) => {
    return await axios1.put(`/products/dashboard/${id}`, data)
  }
})