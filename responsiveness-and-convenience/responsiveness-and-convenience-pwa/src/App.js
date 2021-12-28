import React from "react";
import { BrowserRouter, Switch, Route } from "react-router-dom";
import Home from "./Home";
import PageA from "./PageA";

const App = () => {
  return (
    <>
      <BrowserRouter>
        <Switch>
          <Route exact path='/'>
            <Home />
          </Route>
          <Route path='/page-a'>
            <PageA />
          </Route>
        </Switch>
      </BrowserRouter>
    </>
  );
};

export default App;
