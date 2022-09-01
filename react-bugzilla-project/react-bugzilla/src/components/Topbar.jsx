import React from "react";
import { useNavigate } from "react-router-dom";
import "./Topbar.css";
const Topbar = () => {
  const navigate=useNavigate();
  return (

    <div class="container-fluid bg-warning bar">
      <h1 className="text-dark text-decoration-none text-left ml-5" onClick={() =>{
        navigate('/');
      }}>
        Bugzilla
      </h1>
    </div>
  );
};

export default Topbar;
