// axios1: attact token
// axios2: no token
export default (axios1, axios2) => ({
  login: async (data) => {
    return await axios2.post(`/auth/login`, data);
  },
});
