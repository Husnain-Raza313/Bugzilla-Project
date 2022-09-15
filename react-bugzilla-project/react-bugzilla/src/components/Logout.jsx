import React from 'react'
import { useNavigate } from 'react-router-dom';

const Logout = () => {
  const navigate= useNavigate();
  return (
    <div className='mt-5'>
    <button className='btn btn-danger' onClick={() => {
      localStorage.setItem('user_token', "");
      navigate('/');
    }}>Logout</button>
    </div>
  )
}

export default Logout
