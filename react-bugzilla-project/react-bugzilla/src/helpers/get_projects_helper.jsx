import axios from "axios";
export const GetProjectsHelper = async () => {
  let api_response;
  let url = "http://localhost:3000/api/v1/projects";
  await axios.get(url).then((response) => {
    api_response = response;
  });
  return api_response;
};
