import logo from './logo.svg';
import './App.css';
import Topbar from './components/Topbar';
import BugList from './pages/BugList';
import BugShow from './pages/BugShow';

function App() {
  return (
    <div className="App">
      <Topbar />
      <BugList />
      <BugShow />
    </div>
  );
}


export default App;
