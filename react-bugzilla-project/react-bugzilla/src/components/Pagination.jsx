import React, { useEffect, useState } from 'react'

const Pagination = (props) => {
  let PageNumbers= [];

  for(let i = 1; i <= Math.ceil(props.totalElements /props.elementsPerPage ); i++){
        PageNumbers.push(i);

      }


  return (

   <nav className='d-flex justify-content-center align-items-center'>
   <ul className='pagination'>
      {PageNumbers.map(pageNumber =>(
        <li key={pageNumber} className="page-item">
        <a onClick={() => props.paginate(pageNumber)  } className= {'btn btn-secondary '+(pageNumber === props.currentPage ? 'active' : '') }>
          {pageNumber}
        </a>
        </li>
      ))}
   </ul>
   </nav>
  )
}

export default Pagination
