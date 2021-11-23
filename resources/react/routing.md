---
layout: single
classes: wide
title:  "React - Routing"
date:   2021-11-15 10:00:50 +0800
categories: react
allow_different_nesting: true
toc: true
toc_label: "In this page"
toc_icon: " "
toc_sticky: true
sidebar:
  nav: "react"
---

## Routing (0:53)

### 1 - Introduction

* route parameters
* query string
* redirect
* 404
* nested routing

### 2 - setup

* download resource.zip
* extract resource.zip
* cd start/router-app
  * npm i
  * npm start
* visual studio code
  * install Auto Import - ES6, TS, JSX, TSX

### 3 - adding routing

* react router dom
  * route to component based on path
* cd start/router-app
* npm i react-router-dom@4.3.1
* start/router-app/src/index.js

```js
...
import { BrowserRouter } from "react-router-dom";
...
  <BrowserRouter>
    <App />
  </BrowserRouter>,
  ...
);
...
```

* start/router-app/app.js

```js
...
import { Route } from "react-router-dom";
class App extends Component {
  render() {
    return (
          ...
          <Route path="/products" component={Products} />
          <Route path="/posts" component={Posts} />
          <Route path="/admin" component={Dashboard} />
          <Route path="/" component={Home} />
          ...
    );
  }
}

export default App;
```

### 4 - switch

* /products page shows both products and home components
  * to solve, use 
    * <Router exact>, OR
    * <Switch> 
      * will find exact match and stop processing
* app.js

```js
...
import { Route, Switch } from "react-router-dom";
class App extends Component {
  render() {
  ...
          <Switch>
            <Route path="/products" component={Products} />
...
          </Switch>
...
    );
  }
}

export default App;
```

### 5 - Link

* clickong only any link will refetch all resources
  * bundle.js
    * consists of all components in javascript
  * slow if refetch everytime
    * solve using Link
      * change
        * a to Link
        * href to "to"
* navbar.js

```js
import React from "react";
import { Link } from "react-router-dom";
const NavBar = () => {
  return (
      ...
        <Link to="/">Home</Link>
      ...
  );
};

export default NavBar;
```

### 6 - Route Props

* every routing, components will be injected with 3 extra props - refer <https://v5.reactrouter.com/web/guides/quick-start>
  * history - "past" info
  * location - "now" info
  * match - inforamtion on how url is matched

### 7 - Passing props

* how to add custom props to router?
  * use Router.render
    * it will go to this.props (i.e. this.props.sortBy)
* App.js

```js
...
class App extends Component {
  render() {
...
            <Route
              path="/products"
              render={(props) => <Products sortBy="newest" {...props} />}
            />
...
```
  
### 8 - Router parameters

* how to pass router parameters?
  * use ":"
    * will be stored in this.props.match.params
* App.js

```js
...
class App extends Component {
  render() {
    return (
...
            <Route path="/products/:id" component={ProductDetails} />
            <Route
              path="/products"
              render={(props) => <Products sortBy="newest" {...props} />}
            />
            <Route path="/posts/:year/:month" component={Posts} />
...
    );
  }
}
...
```

### 9 - Optional parameters

* use "?" (javascript means optional)
  * without "?", Switch will pick the next best in line (HOME)
* App.js

```js
...
class App extends Component {
  render() {
    return (
      ...
            <Route path="/posts/:year?/:month?" component={Posts} />
            ...
    );
  }
}
...
```

* posts.jsx

```js
...
const Posts = ({ match }) => {
...
      Year: {match.params.year}, Month:{match.params.month}
...
```

### 10 - query string parameters

* queyr parameter is stored in this.props.location.search
* to extract
  * npm i query-string@6.1.0
* queryString.parse always returns resuls in string value (need to parse yurself)
* <http://localhost:3000/posts/2018?sortBy=newest&approved=true>
* posts.jsx

```js
...
const Posts = ({ match, location }) => {
  const result = queryString.parse(location.search);
...
```

### 11 - Redirects

* use Redirect component
  * from/to
  * to
* app.js

```js
import { Route, Switch, Redirect } from "react-router-dom";
class App extends Component {
  render() {
    return (
...
            <Route path="/not-found" component={NotFound} />
            <Redirect from="/messages" to="/posts" />
            <Redirect to="/not-found" />
...
    );
  }
}

export default App;
```

### 12 - Programmatic Navigation

* use this.props.history
  * push - add new address into history and redirect
  * replace - replace current url with no hstory
    * mostly use in login page (after login successful then click back will not go back to login page)
* productDetails.jsx

```js
...
  handleSave = () => {
    // Navigate to /products
    this.props.history.push("/products");
  };
...
```

### 13 - nested routing

* dashboard.jsx

```js
...
import SideBar from "./sidebar";
import { Route } from "react-router-dom";
import Users from "./users";
import Posts from "./posts";
const Dashboard = ({ match }) => {
  return (
...
      <SideBar />
      <Route path="/admin/users" component={Users} />
      <Route path="/admin/posts" component={Posts} />
...
  );
};

export default Dashboard;
```

* SideBar.jsx

```jsx
...
import { Link } from "react-router-dom";
class SideBar extends React.Component {
  render() {
    return (
      <ul>
        <li>
          <Link to="/admin/posts">Posts</Link>
        </li>
        <li>
          <Link to="/admin/users">Users</Link>
        </li>
      </ul>
    );
  }
}

export default SideBar;
```

### 14 - Execise

* add menu and link to(use NavLink) - done
  * movies - done
  * customers - done
  * rentals - done
* invalid url - done
  * redirect to not-found - done
* root url redirect to movies url - done
* click movie title, redirect to movies/id details page
  * add save button
    * click redirect to movies landing page

### 15/16/17/18 - Adding React Router/Adding Routes/Adding the NavBar/Linking to the MovieForm

* index.js

```jsx
...
import { BrowserRouter } from "react-router-dom";
ReactDOM.render(
  <BrowserRouter>
    <App />
  </BrowserRouter>,
  ...
);
...
```

* create components (all return h1)
  * customers.jsx
  * render.jsx
  * notfound.jsx
* App.js

```jsx
...
import Customers from "./components/customers";
import Rentals from "./components/rentals";
import NavBar from "./components/common/navbar";
import NotFound from "./components/common/notfound";
import { Switch, Route, Redirect } from "react-router-dom";
import MovieForm from "./components/movieform";
function App() {
  let menus = [
    { link: "/movies", label: "Movies" },
    { link: "/customers", label: "Customers" },
    { link: "/rentals", label: "Rentals" },
  ];

  return (
    <React.Fragment>
      <NavBar menus={menus} />
      <Switch>
        <Route path="/notfound" component={NotFound} />
        <Route path="/movieform/:movieid" component={MovieForm} />
        <Route path="/movies" component={Movies} />
        <Route path="/customers" component={Customers} />
        <Route path="/rentals" component={Rentals} />
        <Redirect from="/" exact to="/movies" />
        <Redirect to="/notfound" />
      </Switch>
    </React.Fragment>
  );
}

export default App;
```

* navbar.jsx
  * copy html content from bootstrap

```jsx
import React from "react";
import { NavLink } from "react-router-dom";
class NavBar extends React.Component {
  render() {
    return (
      <nav className="navbar navbar-expand-lg navbar-light bg-light">
        <div className="collapse navbar-collapse" id="navbarSupportedContent">
          <ul className="navbar-nav mr-auto">
            {this.props.menus.map((m) => (
              <li className="nav-item m-2 ">
                <NavLink className="nav-link" to={m.link}>
                  {m.label}
                </NavLink>
              </li>
            ))}
          </ul>
        </div>
      </nav>
    );
  }
}

export default NavBar;
```

* movietable.jsx

```jsx
...
import { Link } from "react-router-dom";
class MovieTable extends React.Component {
  render() {
    let columns = [
      {
        ...
        content: (movie) => (
          <Link to={"/movieform/" + movie._id}>{movie.title}</Link>
        ),
      },
      ...
```

* movieform.jsx
  * copy html from bootstrap's form

```jsx
import React, { Component } from "react";
class MovieDetails extends React.Component {
  render() {
    return (
      <React.Fragment>
        <form className="m-2">
          <div class="form-group">
            <div>MovieDetails({this.props.match.params["movieid"]})</div>
          </div>
          <button
            type="submit"
            class="btn btn-primary"
            onClick={() => this.props.history.push("/movies")}
          >
            Submit
          </button>
        </form>
      </React.Fragment>
    );
  }
}

export default MovieDetails;

```