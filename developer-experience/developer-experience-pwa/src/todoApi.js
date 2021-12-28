import axios from "axios";
import Todo from "./model/Todo";

const apiBaseURL = "http://10.0.0.160:5000/api/v1";

export const getTodos = async () => {
  try {
    const { data } = await axios.get(`${apiBaseURL}/todos`);
    const sortedTodoItems = data.sort((el1, el2) =>
      el2.updatedAt.localeCompare(el1.updatedAt)
    );
    const todos = sortedTodoItems.map((todo) => new Todo(todo));
    return todos;
  } catch (error) {
    alert(error);
  }
};

export const getTodo = async (id) => {
  try {
    const { data } = await axios.get(`${apiBaseURL}/todos/${id}`);
    const todo = new Todo(data);
    return todo;
  } catch (error) {
    alert(error);
  }
};

export const updateTodo = async (todo, id) => {
  try {
    await axios.patch(`${apiBaseURL}/todos/${id}`, todo);
    return;
  } catch (error) {
    alert(error);
  }
};

export const addTodo = async (todo) => {
  try {
    await axios.post(`${apiBaseURL}/todos`, todo);
    return;
  } catch (error) {
    alert(error);
  }
};

export const deleteTodo = async (id) => {
  try {
    await axios.delete(`${apiBaseURL}/todos/${id}`);
    return;
  } catch (error) {
    alert(error);
  }
};
