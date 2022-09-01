import React from 'react'
import { useSearchParams } from 'react-router-dom';

const ErrorPage = () => {

  const [searchParams] = useSearchParams();
  const msg=searchParams.get('msg');

  const checkMessage=() => {
    console.log(msg);
    if (msg === 'ERR_NETWORK') {
      return "Sorry Can't Connect to The Server";
    } else if(msg === "ERR_BAD_REQUEST") {
      return "Record Not Found!!!";
    }
    else if(msg === "ERR_BAD_RESPONSE") {
      return "Server Encountered An Error";
    }
  };

  return (
    <div className='container'><h1 className='text-danger bg-light mt-5'>{msg ? checkMessage() : "Page Not Found"}</h1></div>
  )
}

export default ErrorPage
