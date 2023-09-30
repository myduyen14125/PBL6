// axios1: attact token
// axios2: no token
export default (axios1, axios2) => ({
  getListService: async (queryObj = {}) => {
    const { page = 1, paging = 10, category = '', content = '', status = ''} = queryObj
    return await axios1.get(`/services?page=${page}&paging=${paging}&category_id=${category ?? ""}&content=${content ?? ""}&status=${status ?? ""}`)
  },
  getServiceById: async (id) => {
    return await axios1.get(`/services/${id}`)
  },
  createNewService: async (data) => {
    return await axios2.post(`/services`, data)
  },
  markDoneService: async (id) => {
    return await axios1.patch(`/services/${id}/mark-done`)
  },
  markDoingService: async (id) => {
    return await axios1.patch(`/services/${id}/mark-doing`)
  },
  getNotificationCount: async () => {
    return await axios1.get(`/services/count`)
  }
})