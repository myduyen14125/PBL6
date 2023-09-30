// axios1: attact token
// axios2: no token
export default (axios1, axios2) => ({
  getListNews: async (queryObj = {}) => {
    const { page = 1, paging = 10, category = '', content = ''} = queryObj
    return await axios1.get(`/news/dashboard?page=${page}&paging=${paging}&category_id=${category ?? ""}&content=${content ?? ""}`)
  },
  getNewsById: async (id) => {
    return await axios1.get(`/news/dashboard/${id}`)
  },
  markPublicNews: async (id) => {
    return await axios1.patch(`/news/dashboard/${id}/public`)
  },
  createNews: async (data) => {
    return await axios1.post(`/news/dashboard`, data)
  },
  updateNews: async (id, data) => {
    return await axios1.put(`/news/dashboard/${id}`, data)
  }
})