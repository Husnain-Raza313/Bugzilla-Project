import React from 'react'

const Table = () => {
  return (
    <div>
    <table class="table table-hover table-striped table-bordered container">
    <thead >
      <tr class="table-dark">
      <th scope="col">Title</th>
      <th scope="col">Project ID</th>
      <th scope="col">Status</th>
      <th scope="col">Created At</th>
      <th scope="col">Updated At</th>
      <th scope="col"></th>
      <th scope="col"></th>
      </tr>
    </thead>
    <tbody>
        <tr>
        <td>Bug123</td>
        <td>523</td>
        <td>new</td>
        <td>2022-08-14 19:49:45 UTC</td>
        <td>2022-08-14 19:49:45 UTC</td>
        <td><button className='btn btn-warning'>Show</button></td>
        </tr>
      </tbody>
    </table>
    </div>
  )
}

export default Table
