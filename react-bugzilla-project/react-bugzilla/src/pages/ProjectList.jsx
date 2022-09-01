import { React, useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import ProjectTable from "../components/ProjectTable";
import { getProjects } from "../api/index";

const ProjectList = () => {
  const [projects, setProjects] = useState([]);
  let navigate = useNavigate();

  const getData = async () => {
    try {
      let res = await getProjects();
      setProjects(res.data);
      console.log(res.data);
    } catch (e) {
      navigate(`/errorpage?msg=${e.code}`);
    }
  };
  useEffect(() => {
    getData();
  }, []);

  return (
    <div>
      <h1 className="text-left mt-5 ml-5 container"> All Projects </h1>
      <table class="table table-hover table-striped table-bordered container">
        <thead>
          <tr class="table-dark">
            <th scope="col">Project ID</th>
            <th scope="col">Project Title</th>
            <th scope="col">Created At</th>
            <th scope="col">Updated At</th>
            <th scope="col"></th>
          </tr>
        </thead>
        <tbody>
          {projects &&
            projects.map((project) => (
              <ProjectTable key={project.id} project={project} />
            ))}
        </tbody>
      </table>
      <button className="btn btn-primary" onClick={() => navigate("/")}>
        Bugs List
      </button>
    </div>
  );
};

export default ProjectList;
