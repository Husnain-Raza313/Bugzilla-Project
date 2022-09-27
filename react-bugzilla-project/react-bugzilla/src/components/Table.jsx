import React from "react";
import { useNavigate } from "react-router-dom";

const Table = (props) => {
  let navigate = useNavigate();
  const showBug = (id) => {
    navigate(`/show/${id}`);
  };
  return (
    <table class="table table-hover table-striped table-bordered container">
        <thead>
          <tr class="table-dark" >
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
        {props.bugs && props.bugs.map((bug) =>
        <tr key={bug.id}>
          <td>{bug.id}</td>
          <td>{bug.title}</td>
          <td>{bug.project_id}</td>
          <td>{bug.piece_status}</td>
          <td>{bug.piece_type}</td>
          <td>{bug.qa_id}</td>
          <td>
            <button
              className="btn btn-warning"
              onClick={() => showBug(bug.id)}
            >
              Show
            </button>
          </td>
        </tr>
        )}
        </tbody>
        </table>
      );


};

export default Table;
