import React, { useEffect } from "react";
import styles from "./PageA.module.css";
import { useHistory } from "react-router-dom";

const PageA = () => {
  const history = useHistory();

  useEffect(() => {
    console.log("after navigating to PageA", Date.now());
  });

  const handleGoBack = () => {
    history.goBack();
  };

  return (
    <div className={styles.container}>
      <div className='header'>
        <div onClick={handleGoBack}>Back</div>
        <h1 style={{ flex: 1, marginLeft: "1rem" }}>Page A</h1>
      </div>
      <div className={styles.bodyContainer}>
        <p>Page A</p>
      </div>
    </div>
  );
};

export default PageA;
