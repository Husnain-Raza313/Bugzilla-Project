export const paginationData =(currentPage, itemsPerPage , item) =>{
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentItems= item.slice(indexOfFirstItem, indexOfLastItem);
  return currentItems;
};
