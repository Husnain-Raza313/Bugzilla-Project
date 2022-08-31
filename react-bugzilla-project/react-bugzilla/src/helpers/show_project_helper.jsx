import axios from "axios";
export const ShowProjectHelper = async (id) => {
  let api_response
  let url = `http://localhost:3000/api/v1/projects/${id}`
await axios.get(url).then((response)=>{
api_response =  response
})
return api_response
}
