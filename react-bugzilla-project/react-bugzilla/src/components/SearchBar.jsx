import React from "react";
import { fetchData } from "../api/index";
import "./SearchBar.css";


const SearchBar = (props) => {
  let user = localStorage.getItem("user_token")
  const handleChange = async (e) =>{
    console.log(e.target.value);
    await props.changeValues(await getData(e.target.value));

  };
  const getData = async (value) => {
    let res = await fetchData(`${props.address}?query=${value}`);
    console.log(res);
    return res;
};
  return (
    <div className="m-5 search-bar">

      {
        user && <div>
        <h2>Search Your Queries Directly</h2>
        <div className="input-group ml-5">
          <div className="form-outline">
            <input type="search" id="form1" className="form-control-lg" onChange={(e)=>handleChange(e)} placeholder="Search" />
          </div>
        </div>
      </div>
      }
    </div>
  );
};

export default SearchBar;
