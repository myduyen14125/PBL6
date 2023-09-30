// axios1: attact token
// axios2: no token
export default (axios1, axios2) => ({
  getListPosition: async () => {
    return await axios1.get(`/applications/positions`)
  },
  getPositionById: async (id) => {
    return await axios1.get(`/applications/positions/${id}`)
  },
  createPosition: async (data) => {
    return await axios1.post(`/applications/positions`, data)
  },
  updatePosition: async (id, data) => {
    return await axios1.put(`/applications/positions/${id}`, data)
  },
  deletePosition: async (id) => {
    return await axios1.delete(`/applications/positions/${id}`)
  }
})