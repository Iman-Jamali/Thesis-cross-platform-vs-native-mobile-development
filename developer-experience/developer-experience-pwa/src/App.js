import { BrowserRouter, Switch, Route } from "react-router-dom";
import TodoList from "./pages/TodoListPage/TodoList";
import EditTodo from "./pages/EditTodoPage/EditTodo";

function App() {
  return (
    <BrowserRouter>
      <Switch>
        <Route exact path={"/"} component={TodoList} />
        <Route exact path={"/create"} component={EditTodo} />
        <Route exact path={"/:todoId"} component={EditTodo} />
      </Switch>
    </BrowserRouter>
  );
}

export default App;
