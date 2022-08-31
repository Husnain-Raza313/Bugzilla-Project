import {React, useState, useEffect} from 'react';
import { useNavigate, useParams } from 'react-router-dom';
import { ShowProjectHelper } from '../helpers/show_project_helper';

const ProjectShow = () => {
  let {id} = useParams();
  const [project,setProject] = useState({});
  const [users,setUsers] = useState([]);
  let navigate= useNavigate();

  const projectList = ()=>{
    navigate('/projects');
  }

  const getData=async () => {
    try{
    let res= await ShowProjectHelper(id);
      setProject(res.data[0]);
      setUsers(res.data[1]);
      console.log(res.data[1]);
      checkProject(res.data[0]);
    }catch(e){
      alert(e.message);
    }
  }

  const checkProject = async (data) => {
    if(data.name === undefined){
      alert("NO SUCH PROJECT EXISTS");
      navigate('/projects');
    }
  }

  useEffect(() => {
    getData();
  }, []);


  return (
    <div>
    <div class="jumbotron-index m-5 mt-5">
    <div class="jumbotron text-left">
    <h4 className='mb-3'>Project ID:  {project.id}</h4>
    <h4 className='mb-3'>Title: {project.name}</h4>
    <h4 className='mb-3'>Manager ID : {project.user_id}</h4>
    <h4>Assigned User IDs: </h4>{ users.length === 0 ? <p><b>(None) </b></p>
    : users && users.map((user) => <p>
    <b>
    <i className='ml-5 mb-0'>User ID: {user.id}, Email: {user.email}, Name: {user.name}</i>
    </b>
    </p>  ) }
    <br />
    <p class="lead">
    <button className='btn btn-dark' onClick={projectList}>Projects List</button>
    </p>
  </div>
</div>
    </div>
  )
}

export default ProjectShow
