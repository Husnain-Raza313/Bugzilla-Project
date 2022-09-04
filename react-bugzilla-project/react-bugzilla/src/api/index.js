import axios from "axios";

let apiResponse;

const fetchData = async (address) => {
  try{
await axios({
    method: 'get',
    url: `http://localhost:3000/api/v1/${address}`,
    responseType: 'json'
  })
    .then(function (response) {
     apiResponse= response.data;

    });
   return await apiResponse;
  }
  catch (e) {
    window.location.replace(`/errorpage?msg=${e.code}`);
  }

};

export {fetchData};
