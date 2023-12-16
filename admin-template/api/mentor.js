// axios1: attact token
// axios2: no token
export default (axios1, axios2) => ({
  getListMentor: async (queryObj = {}) => {
    const { page = 1 } = queryObj;
    return await axios1.get(`/mentor?page=${page}`);
  },

  getListSearchMentor: async (queryObj = {}) => {
    const { page = 1, name = "", expertise = "" } = queryObj;
    return await axios1.get(
      `/mentor/search?page=${page}&name=${name ?? ""}&expertise=${
        expertise ?? ""
      }`
    );
  },

  getListSearchExpertise: async () => {
    return await axios1.get("/expertise");
  },

  getListBlog: async (queryObj = {}) => {
    const { page = 1 } = queryObj;
    return await axios1.get(`/blog?page=${page}`);
  },

  getContactById: async (id) => {
    return await axios1.get(`/contacts/${id}`);
  },
  createNewContact: async (data) => {
    return await axios2.post(`/contacts`, data);
  },
  markDoneContact: async (id) => {
    return await axios1.patch(`/contacts/${id}/mark-done`);
  },
  markDoingContact: async (id) => {
    return await axios1.patch(`/contacts/${id}/mark-doing`);
  },
  // getNotificationCount: async () => {
  //   return await axios1.get(`/contacts/count`)
  // }
});
