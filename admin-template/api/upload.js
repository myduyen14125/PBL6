// axios1: attact token
// axios2: no token
export default (axios1, axios2) => ({
  uploadFile: async (data) => {
    return await axios1.post(`/storages`, data)
  },
  uploadMultipleFile: async (data) => {
    return await axios1.post(`/storages/multiple`, data)
  },
  deleteFile: async (url) => {
    return await axios1.delete(`/storages?url=${url}`)
  }
})