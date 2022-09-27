import React from "react";
import { useNavigate } from "react-router-dom";

const ProjectTable = (props) => {
  let navigate = useNavigate();
  const showProject = (id) => {
    navigate(`/showproject/${id}`);
  };
  return (
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
          {props.projects &&
            props.projects.map((project) => (
      <tr key={project.id} >
      <td>{project.id}</td>
      <td>{project.name}</td>
      <td>{project.created_at}</td>
      <td>{project.updated_at}</td>
      <td>
        <button
          className="btn btn-warning"
          onClick={() => showProject(project.id)}
        >
          Show
        </button>
      </td>
    </tr>
            ))}
        </tbody>
      </table>

  );
};

export default ProjectTable;
