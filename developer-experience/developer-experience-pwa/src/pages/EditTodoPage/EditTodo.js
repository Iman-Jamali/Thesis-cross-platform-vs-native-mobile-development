import React, { useState, useEffect } from "react";
import { useParams, useHistory } from "react-router-dom";
import AppBar from "@mui/material/AppBar";
import Toolbar from "@mui/material/Toolbar";
import Typography from "@mui/material/Typography";
import Button from "@mui/material/Button";
import IconButton from "@mui/material/IconButton";
import ArrowBackIcon from "@mui/icons-material/ArrowBack";
import TextField from "@mui/material/TextField";
import styles from "./EditTodo.module.css";
import { getTodo, addTodo, updateTodo, deleteTodo } from "../../todoApi";

const EditTodo = () => {
  const [title, setTitle] = useState({ value: "", touched: false });
  const [description, setDescription] = useState({ value: "", touched: false });
  const [isEdit, setIsEdit] = useState(false);
  const { todoId } = useParams();
  const history = useHistory();

  useEffect(() => {
    setIsEdit(Boolean(todoId));
  }, [todoId]);

  useEffect(() => {
    if (isEdit) {
      (async () => {
        const todo = await getTodo(todoId);
        setTitle({ value: todo.title, touched: false });
        setDescription({ value: todo.description, touched: false });
      })();
    }
  }, [todoId, isEdit]);

  const handleChange = (event) => {
    const name = event.target.name;
    const value = event.target.value;
    if (name === "title") {
      setTitle({ value, touched: true });
    } else if (name === "description") {
      setDescription({ value, touched: true });
    }
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    if (!title.value || !description.value) {
      setTitle({ ...title, touched: true });
      setDescription({ ...description, touched: true });
      return;
    }
    const todoItem = {
      title: title.value,
      description: description.value,
    };
    try {
      if (isEdit) {
        await updateTodo(todoItem, todoId);
      } else {
        await addTodo(todoItem);
      }
      handleGoBack();
    } catch (error) {
      alert(error);
    }
  };

  const handleGoBack = () => {
    history.goBack();
  };

  const handleDelete = async () => {
    await deleteTodo(todoId);
    handleGoBack();
  };

  return (
    <div className={styles.pageContainer}>
      <AppBar position='static'>
        <Toolbar>
          <IconButton color='inherit' onClick={handleGoBack}>
            <ArrowBackIcon />
          </IconButton>
          <Typography variant='h6' style={{ marginLeft: 16 }}>
            {isEdit ? "Edit Todo" : "Add Todo"}
          </Typography>
        </Toolbar>
      </AppBar>
      <form className={styles.form} onSubmit={handleSubmit}>
        <TextField
          name='title'
          label='Title'
          onChange={handleChange}
          value={title.value}
          error={title.value === "" && title.touched}
          helperText={
            title.value === "" && title.touched && "Title is required!"
          }
          style={{ marginBottom: 16 }}
        />
        <TextField
          name='description'
          label='Description'
          onChange={handleChange}
          value={description.value}
          error={description.value === "" && description.touched}
          helperText={
            description.value === "" &&
            description.touched &&
            "Description is required!"
          }
        />
        <div className={styles.formAction}>
          <Button onClick={handleGoBack}>Cancel</Button>
          {isEdit && (
            <Button onClick={handleDelete} color='error'>
              Delete
            </Button>
          )}
          <Button type='submit'>{isEdit ? "Update" : "Add"}</Button>
        </div>
      </form>
    </div>
  );
};

export default EditTodo;
