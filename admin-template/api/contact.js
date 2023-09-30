// axios1: attact token
// axios2: no token
export default (axios1, axios2) => ({
  getListContact: async (queryObj = {}) => {
    const { page = 1, paging = 10, subject = '', content = '', status = ''} = queryObj
    return await axios1.get(`/contacts?page=${page}&paging=${paging}&subject_id=${subject ?? ""}&content=${content ?? ""}&status=${status ?? ""}`)
  },
  getContactById: async (id) => {
    return await axios1.get(`/contacts/${id}`)
  },
  createNewContact: async (data) => {
    return await axios2.post(`/contacts`, data)
  },
  markDoneContact: async (id) => {
    return await axios1.patch(`/contacts/${id}/mark-done`)
  },
  markDoingContact: async (id) => {
    return await axios1.patch(`/contacts/${id}/mark-doing`)
  },
  getNotificationCount: async () => {
    return await axios1.get(`/contacts/count`)
  }
})