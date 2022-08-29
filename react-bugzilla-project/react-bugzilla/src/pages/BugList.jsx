import {React, useState, useEffect} from 'react';
import Table from '../components/Table';
import { GetBugsHelper } from '../helpers/get_bugs_helper';


const BugList = () => {
  const [bugs,setBugs] = useState([]);
  const getData=async () => {
    let res= await GetBugsHelper();
    setBugs(res.data);
      console.log(res.data);
  }
  useEffect(() => {
    getData();
  }, []);

  return (
    <div>
    <h1 className='text-left mt-5 ml-5 container'> All Bugs </h1>
    <table class="table table-hover table-striped table-bordered container">
    <thead >
      <tr class="table-dark">
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
   { bugs && bugs.map((bug) => <Table key={bug.id} bug={bug}/>) }
    </tbody>
    </table>
    </div>
  )
}

export default BugList
