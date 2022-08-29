import axios from "axios";
export const GetBugsHelper = async () => {
  var api_response
  let url = 'http://localhost:3000/api/v1/bugs'
await axios.get(url).then((response)=>{
api_response =  response
})
return api_response
}
