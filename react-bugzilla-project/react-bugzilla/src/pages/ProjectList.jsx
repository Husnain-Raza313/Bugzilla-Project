import { React, useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import ProjectTable from "../components/ProjectTable";
import { fetchData } from "../api/index";
import SearchBar from "../components/SearchBar";
import Pagination from "../components/Pagination";
import { paginationData } from "../utilities/paginationData";

const ProjectList = () => {
  const [projects, setProjects] = useState([]);
  const [currentPage, setCurrentPage] = useState(1);
  const [projectsPerPage, setProjectsPerPage] = useState(3);

  const currentProjects= paginationData(currentPage, projectsPerPage, projects);
  const paginate = pageNumber => setCurrentPage(pageNumber);

  let navigate = useNavigate();

  const getData = async () => {
      let res = await fetchData("projects");
      setProjects(res);
  };

  useEffect(() => {
    getData();
  }, []);

  return (
    <div>
    <SearchBar  changeValues={(projectsArray) => setProjects(projectsArray)} address='projects' />
    <div>
      <h1 className="text-left mt-5 ml-5 container"> All Projects </h1>
      <ProjectTable projects={currentProjects} />
      <Pagination elementsPerPage={projectsPerPage} totalElements={projects.length} paginate={paginate} currentPage={currentPage} />
      <button className="btn btn-primary" onClick={() => navigate("/list")}>
        Bugs List
      </button>
    </div>
    </div>
  );
};

export default ProjectList;
