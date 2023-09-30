// axios1: attact token
// axios2: no token
export default (axios1, axios2) => ({
  getListJob: async (queryObj = {}) => {
    const { page = 1, paging = 10, content = '', type = ''} = queryObj
    return await axios1.get(`/jobs/dashboard?page=${page}&paging=${paging}&content=${content ?? ""}&type=${type ?? ""}`)
  },
  getJobById: async (id) => {
    return await axios1.get(`/jobs/dashboard/${id}`)
  },
  markPublicJob: async (id) => {
    return await axios1.patch(`/jobs/dashboard/${id}/public`)
  },
  createJob: async (data) => {
    return await axios1.post(`/jobs/dashboard`, data)
  },
  updateJob: async (id, data) => {
    return await axios1.put(`/jobs/dashboard/${id}`, data)
  }
})