// axios1: attact token
// axios2: no token
export default (axios1, axios2) => ({
  getListApplication: async (queryObj = {}) => {
    const { page = 1, paging = 10, position = '', content = '', status = ''} = queryObj
    return await axios1.get(`/applications?page=${page}&paging=${paging}&position_id=${position ?? ""}&content=${content ?? ""}&status=${status ?? ""}`)
  },
  getApplicationById: async (id) => {
    return await axios1.get(`/applications/${id}`)
  },
  createNewApplication: async (data) => {
    return await axios2.post(`/applications`, data)
  },
  markDoneApplication: async (id) => {
    return await axios1.patch(`/applications/${id}/mark-done`)
  },
  markDoingApplication: async (id) => {
    return await axios1.patch(`/applications/${id}/mark-doing`)
  },
  getNotificationCount: async () => {
    return await axios1.get(`/applications/count`)
  }
})