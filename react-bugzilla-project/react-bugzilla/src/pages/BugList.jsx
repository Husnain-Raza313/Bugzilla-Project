import { React, useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import Table from "../components/Table";
import Logout from "../components/Logout";
import { fetchData } from "../api/index";
import SearchBar from "../components/SearchBar";
import Pagination from "../components/Pagination";
import { paginationData } from "../utilities/paginationData";

const BugList = () => {
  const [bugs, setBugs] = useState([]);
  const [currentPage, setCurrentPage] = useState(1);
  const [bugsPerPage, setBugsPerPage] = useState(3);
  let navigate = useNavigate();

  const currentBugs= paginationData(currentPage, bugsPerPage, bugs);
  const paginate = pageNumber => setCurrentPage(pageNumber);

  const getData = async () => {
      let res = await fetchData("bugs");
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
      <Table bugs={currentBugs} />
      <Pagination elementsPerPage={bugsPerPage} totalElements={bugs.length} paginate={paginate} currentPage={currentPage} />
      <button className="btn btn-primary" onClick={projectList}>
        Projects List
      </button>

      <Logout />
    </div>
    </div>
  );
};

export default BugList;
