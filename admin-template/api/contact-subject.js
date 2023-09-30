// axios1: attact token
// axios2: no token
export default (axios1, axios2) => ({
  getListSubject: async () => {
    return await axios1.get(`/contacts/subjects`)
  },
  getSubjectById: async (id) => {
    return await axios1.get(`/contacts/subjects/${id}`)
  },
  createSubject: async (data) => {
    return await axios1.post(`/contacts/subjects`, data)
  },
  updateSubject: async (id, data) => {
    return await axios1.put(`/contacts/subjects/${id}`, data)
  },
  deleteSubject: async (id) => {
    return await axios1.delete(`/contacts/subjects/${id}`)
  }
})