// axios1: attact token
// axios2: no token
export default (axios1, axios2) => ({
  getListActivity: async (queryObj = {}) => {
    const { page = 1, paging = 10, content = ''} = queryObj
    return await axios1.get(`/activities/dashboard?page=${page}&paging=${paging}&content=${content ?? ""}`)
  },
  getActivityById: async (id) => {
    return await axios1.get(`/activities/dashboard/${id}`)
  },
  markPublicActivity: async (id) => {
    return await axios1.patch(`/activities/dashboard/${id}/public`)
  },
  createActivity: async (data) => {
    // console log the data
    // console.log("data activity :", data)
    return await axios1.post(`/activities/dashboard`, data)
  },
  updateActivity: async (id, data) => {
    return await axios1.put(`/activities/dashboard/${id}`, data)
  }
})