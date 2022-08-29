import logo from './logo.svg';
import './App.css';
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Topbar from './components/Topbar';
import BugList from './pages/BugList';
import BugShow from './pages/BugShow';

function App() {
  return (
    <div className="App">
      <BrowserRouter>
      <Topbar />
      <Routes>
        <Route  path="/" element={<BugList />} />
        <Route path="/show" element={<BugShow />} />
      </Routes>
    </BrowserRouter>

    </div>

  );
}


export default App;
