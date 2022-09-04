import "./App.css";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Topbar from "./components/Topbar";
import BugList from "./pages/BugList";
import BugShow from "./pages/BugShow";
import ProjectShow from "./pages/ProjectShow";
import ProjectList from "./pages/ProjectList";
import ErrorPage from "./pages/ErrorPage";

function App() {
  return (
    <div className="App">
      <BrowserRouter>
        <Topbar />
        <Routes>
          <Route path="/" element={<BugList />} />
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
