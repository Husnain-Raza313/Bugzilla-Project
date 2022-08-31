import React from "react";
import { useNavigate } from "react-router-dom";

const Table = (props) => {
  let navigate = useNavigate();
  const showBug = (id) => {
    navigate(`/show/${id}`);
  };
  return (
    <tr>
      <td>{props.bug.id}</td>
      <td>{props.bug.title}</td>
      <td>{props.bug.project_id}</td>
      <td>{props.bug.piece_status}</td>
      <td>{props.bug.piece_type}</td>
      <td>{props.bug.qa_id}</td>
      <td>
        <button
          className="btn btn-warning"
          onClick={() => showBug(props.bug.id)}
        >
          Show
        </button>
      </td>
    </tr>
  );
};

export default Table;
