import "./App.css";
import { useState, useEffect } from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Topbar from "./components/Topbar";
import BugList from "./pages/BugList";
import BugShow from "./pages/BugShow";
import ProjectShow from "./pages/ProjectShow";
import ProjectList from "./pages/ProjectList";
import ErrorPage from "./pages/ErrorPage";
import LoginPage from "./pages/LoginPage";
import SearchBar from "./components/SearchBar";

function App() {
  let user_token = localStorage.getItem("user_token");


  return (
    <div className="App">
      <BrowserRouter>
        <Topbar />
        <Routes>
          <Route path="/" element={<LoginPage />} />
          <Route path="/list" element={<BugList />} />
          <Route path="/show/:id" element={<BugShow />} />
          <Route path="/showproject/:id" element={<ProjectShow />} />
          <Route path="/projects" element={<ProjectList />} />
          <Route path="/errorpage" element={<ErrorPage />} />
          <Route path="*" element={<ErrorPage />} />
        </Routes>
      </BrowserRouter>
    </div>
  );
}

export default App;
