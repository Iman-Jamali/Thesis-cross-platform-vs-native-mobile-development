import React, { useState, useEffect } from "react";
import { useHistory } from "react-router-dom";
import AppBar from "@mui/material/AppBar";
import Toolbar from "@mui/material/Toolbar";
import Typography from "@mui/material/Typography";
import Fab from "@mui/material/Fab";
import AddIcon from "@mui/icons-material/Add";
import { getTodos } from "../../todoApi";
import styles from "./TodoList.module.css";

const TodoList = () => {
  const [data, setData] = useState([]);
  const history = useHistory();

  useEffect(() => {
    (async () => {
      const todos = await getTodos();
      setData(todos);
    })();
  }, []);

  const handleItemClicked = (id) => {
    history.push("/:todoId".replace(":todoId", id));
  };

  const handleAddTodo = () => {
    history.push("/create");
  };

  return (
    <div className={styles.container}>
      <AppBar position='static'>
        <Toolbar>
          <Typography variant='h6'>Todo List</Typography>
        </Toolbar>
      </AppBar>
      <div className={styles.fab}>
        <Fab color='primary' onClick={handleAddTodo}>
          <AddIcon />
        </Fab>
      </div>

      {data.map((el) => {
        return (
          <div
            className={styles.itemsContainer}
            key={el.id}
            onClick={() => handleItemClicked(el.id)}
          >
            <div style={{ padding: 16 }}>
              <div className={styles.title}>{el.title}</div>
              <div className={styles.updatedAt}>{el.updatedAt}</div>
              <div className={styles.description}>{el.description}</div>
            </div>
          </div>
        );
      })}
    </div>
  );
};

export default TodoList;
