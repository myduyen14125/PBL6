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

  addExpertise: async (data) => {
    const config = {
      headers: {
        Authorization: `Bearer ${sessionStorage.getItem(
          "IT_MENTOR_accessToken"
        )}`,
      },
    };
    await axios1.post("/expertise", data, config);
  },

  deleteExpertise: async (id) => {
    const config = {
      headers: {
        Authorization: `Bearer ${sessionStorage.getItem(
          "IT_MENTOR_accessToken"
        )}`,
      },
    };
    return await axios1.delete(`/expertise/${id}`, config);
  },

  updateExpertise: async (data) => {
    const config = {
      headers: {
        Authorization: `Bearer ${sessionStorage.getItem(
          "IT_MENTOR_accessToken"
        )}`,
      },
    };
    console.log("data name:", data.name);
    let name = {
      name: data.name,
    };
    return await axios1.patch(`/expertise/${data._id}`, name, config);
  },

  getListMentee: async () => {
    const config = {
      headers: {
        Authorization: `Bearer ${sessionStorage.getItem(
          "IT_MENTOR_accessToken"
        )}`,
      },
    };
    return await axios1.get("/user/mentees", config);
  },

  getListSearchMentee: async (queryObj = {}) => {
    const { page = 1, name = "" } = queryObj;
    const config = {
      headers: {
        Authorization: `Bearer ${sessionStorage.getItem(
          "IT_MENTOR_accessToken"
        )}`,
      },
    };
    return await axios1.get(
      `/user/search?page=${page}&name=${name ?? ""}`,
      config
    );
  },

  getListBlog: async (queryObj = {}) => {
    const { page = 1, title = "" } = queryObj;
    return await axios1.get(`/blog/search?page=${page}&title=${title ?? ""}`);
  },

  createBlog: async (data) => {
    const config = {
      headers: {
        Authorization: `Bearer ${sessionStorage.getItem(
          "IT_MENTOR_accessToken"
        )}`,
      },
    };
    return await axios1.post("/blog", data, config);
  },

  updateBlog: async (data) => {
    const config = {
      headers: {
        Authorization: `Bearer ${sessionStorage.getItem(
          "IT_MENTOR_accessToken"
        )}`,
      },
    };
    return await axios1.patch(`/blog/${data?._id}`, data, config);
  },

  deleteBlog: async (id) => {
    const config = {
      headers: {
        Authorization: `Bearer ${sessionStorage.getItem(
          "IT_MENTOR_accessToken"
        )}`,
      },
    };
    return await axios1.delete(`/blog/${id}`, config);
  },

  getBlogById: async (id) => {
    const config = {
      headers: {
        Authorization: `Bearer ${sessionStorage.getItem(
          "IT_MENTOR_accessToken"
        )}`,
      },
    };
    return await axios1.get(`/blog/${id}`, config);
  },

  // getContactById: async (id) => {
  //   return await axios1.get(`/contacts/${id}`);
  // },
  // createNewContact: async (data) => {
  //   return await axios2.post(`/contacts`, data);
  // },
  // markDoneContact: async (id) => {
  //   return await axios1.patch(`/contacts/${id}/mark-done`);
  // },
  // markDoingContact: async (id) => {
  //   return await axios1.patch(`/contacts/${id}/mark-doing`);
  // },
  // getNotificationCount: async () => {
  //   return await axios1.get(`/contacts/count`)
  // }
});
