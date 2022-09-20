import { React, useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import Table from "../components/Table";
import Logout from "../components/Logout";
import { fetchData } from "../api/index";
import SearchBar from "../components/SearchBar";

const BugList = () => {
  const [bugs, setBugs] = useState([]);
  let navigate = useNavigate();

  const getData = async () => {
      let res = await fetchData("bugs");
      console.log(res);
      setBugs(res);
  };

  const projectList = () => {
    navigate("/projects");
  };
  useEffect(() => {
    getData();
  }, []);

  return (
    <div>
    <SearchBar  changeValues={(bugsArray) => setBugs(bugsArray)} address='bugs' />
    <div>
      <h1 className="text-left mt-5 ml-5 container"> All Bugs </h1>
      <table class="table table-hover table-striped table-bordered container">
        <thead>
          <tr class="table-dark">
            <th scope="col">Bug ID</th>
            <th scope="col">Title</th>
            <th scope="col">Project ID</th>
            <th scope="col">Status</th>
            <th scope="col">Type</th>
            <th scope="col">Creator ID</th>
            <th scope="col"></th>
          </tr>
        </thead>
        <tbody>
          {bugs && bugs.map((bug) => <Table key={bug.id} bug={bug} />)}
        </tbody>
      </table>
      <button className="btn btn-primary" onClick={projectList}>
        Projects List
      </button>

      <Logout />
    </div>
    </div>
  );
};

export default BugList;
