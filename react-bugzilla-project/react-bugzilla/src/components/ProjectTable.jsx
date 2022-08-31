import React from 'react'
import { useNavigate } from 'react-router-dom'

const ProjectTable = (props) => {
  let navigate=useNavigate();
  const showProject = (id) => {
    navigate(`/showproject/${id}`);
  }
  return (
    <tr>
        <td>{props.project.id}</td>
        <td>{props.project.name}</td>
        <td>{props.project.created_at}</td>
        <td>{props.project.updated_at}</td>
        <td><button className='btn btn-warning' onClick={()=> showProject(props.project.id)}>Show</button></td>
    </tr>
  )
}

export default ProjectTable
