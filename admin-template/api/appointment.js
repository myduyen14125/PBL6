// axios1: attact token
// axios2: no token
export default (axios1, axios2) => ({
  getListAppointment: async (queryObj = {}) => {
    const { page = 1, status = "" } = queryObj;
    const config = {
      headers: {
        Authorization: `Bearer ${sessionStorage.getItem(
          "IT_MENTOR_accessToken"
        )}`,
      },
    };
    return await axios1.get(
      `/appointment/all?page=${page}&status=${status ?? ""}`,
      config
    );
  },

  getAppointmentById: async (id) => {
    const config = {
      headers: {
        Authorization: `Bearer ${sessionStorage.getItem(
          "IT_MENTOR_accessToken"
        )}`,
      },
    };
    return await axios1.get(`/appointment/${id}`, config);
  },
});
