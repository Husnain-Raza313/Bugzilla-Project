import { React, useState, useEffect } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { ShowBugHelper } from "../helpers/show_bug_helper";
import "./BugShow.css";

const BugShow = () => {
  let { id } = useParams();
  const [bug, setBug] = useState({ screenshot: "no image" });
  let navigate = useNavigate();

  const bugList = () => {
    navigate("/");
  };

  const getData = async () => {
    try {
      let res = await ShowBugHelper(id);
      setBug(res.data);
      checkBug(res.data);
    } catch (e) {
      alert(e.message);
    }
  };
  const checkBug = async (data) => {
    if (data.title === undefined) {
      alert("NO SUCH BUG EXISTS");
      navigate("/");
    }
  };

  useEffect(() => {
    getData();
  }, []);

  return (
    <div>
      <div class="jumbotron-index m-5 mt-0">
        <div class="jumbotron text-left">
          <h4>Title: {bug.title}</h4>
          <h4>Status: {bug.piece_status}</h4>
          <h4>
            Description:{" "}
            {bug.description === "" ? <span>None</span> : bug.description}
          </h4>
          <h4>Screenshot:</h4>
          {bug.screenshot.url === null ? (
            <h6>(No Screenshot Available)</h6>
          ) : (
            <div>
              <img src={bug.screenshot.url} className="bug-screenshot" />
            </div>
          )}
          <h4>
            Deadline: {bug.deadline === null ? <span>None</span> : bug.deadline}
          </h4>
          <h4>Type: {bug.piece_type}</h4>
          <h4>Project ID: {bug.project_id}</h4>

          <h4>Assigned Developer IDs: {bug.developer_ids}</h4>
          <br />
          <p class="lead">
            <button className="btn btn-dark" onClick={bugList}>
              Bugs List
            </button>
          </p>
        </div>
      </div>
    </div>
  );
};

export default BugShow;
