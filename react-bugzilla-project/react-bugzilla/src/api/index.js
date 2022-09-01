import axios from "axios";

let url = "http://localhost:3000/api/v1/";
let api_response;
 const getBugs = async () => {
  await axios.get(url+"bugs").then((response) => {
    api_response = response;
  });
  return api_response;
};
 const getProjects = async () => {
  await axios.get(url+"projects").then((response) => {
    api_response = response;
  });
  return api_response;
};
 const showBug = async (id) => {
  await axios.get(url+`bugs/${id}`).then((response) => {
    api_response = response;
  });
  return api_response;
};

 const showProject = async (id) => {
  await axios.get(url+`projects/${id}`).then((response) => {
    api_response = response;
  });
  return api_response;
};

export {getBugs, getProjects, showBug, showProject};
