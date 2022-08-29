import axios from "axios";
export const ShowBugHelper = async (id) => {
  var api_response
  let url = `http://localhost:3000/api/v1/bugs/${id}`
await axios.get(url).then((response)=>{
api_response =  response
})
return api_response
}
