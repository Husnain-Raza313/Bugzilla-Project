import axios from "axios";

let apiResponse;

const fetchData = async (address) => {
  try{
await axios({
    method: 'get',
    url: `http://localhost:3000/api/v1/${address}`,
    headers: {
      "Authorization": 'Bearer ' + localStorage.getItem('user_token') //the token is a variable which holds the token
    }
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

const sendData = async (address,object) => {
  try{
await axios({
    method: 'post',
    url: `http://localhost:3000/${address}`,
    data: object,

  })
    .then(function (response) {
     apiResponse= response.data;

    });
    window.location.replace(`/list`);
   return await apiResponse;
  }
  catch (e) {
    window.location.replace(`/errorpage?msg=${e.code}`);
  }

};

export {fetchData, sendData};
