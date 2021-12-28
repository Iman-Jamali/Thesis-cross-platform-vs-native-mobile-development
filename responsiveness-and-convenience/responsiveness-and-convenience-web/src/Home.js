import React from "react";
import styles from "./Home.module.css";
import { useHistory } from "react-router-dom";

const Home = () => {
  const history = useHistory();
  const handlePageAClicked = () => {
    console.log("start navigating to PageA", Date.now());
    history.push("page-a");
  };

  return (
    <div className={styles.container}>
      <div className='header'>
        <h1>Home</h1>
      </div>
      <div className={styles.bodyContainer}>
        <button onClick={handlePageAClicked}>Page A</button>
      </div>
    </div>
  );
};

export default Home;
