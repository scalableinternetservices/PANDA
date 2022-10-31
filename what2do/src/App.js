import logo from './logo.svg';
import './App.css';
import Post from './components/Posts';
import axios from "axios";
import { useEffect, useState } from 'react';

const API_URL = "http://localhost:3000/api/";

function getAPIData() {
  return axios.get(API_URL + "posts").then((response) => response.data)
}
function App() {
  const [posts, setPosts] = useState([]);

  useEffect(() => {
    let mounted = true;
    getAPIData().then((items) => {
      if (mounted) {
        setPosts(items);
      }
    });
    return () => (mounted = false);
  },[]);

  return (
    <div className="App">
      <div>Hello</div>
      <Post posts={posts}/>
    </div>
  );
}

export default App;
