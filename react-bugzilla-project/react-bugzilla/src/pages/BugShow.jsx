import React from 'react'
import { useNavigate } from 'react-router-dom'

const BugShow = () => {
  let navigate= useNavigate();
  const bugList = ()=>{
    navigate('/');
  }
  return (
    <div>
    <div class="jumbotron-index m-5 mt-0">
    <div class="jumbotron text-left">
    <h4>Title: </h4>
    <h4>Status:  </h4>
    <h4>Description:
    </h4>
    <h4>Deadline:</h4>
    <h4>Screenshot:</h4>
    <h4>Type: </h4>
    <h4>Project ID: </h4>
    <h4>Assigned Developer IDs: </h4>
    <br />
    <p class="lead">
    <button className='btn btn-dark' onClick={bugList}>Bugs List</button>
    </p>
  </div>
</div>
    </div>
  )
}

export default BugShow
