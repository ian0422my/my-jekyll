---
layout: single
# classes: wide
title:  "React - Forms"
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

## Forms (1:34)

### 1 - Introduction

### 2 - Building a Bootstrap Form

* find html from [bootstrap form](https://getbootstrap.com/docs/4.0/components/forms/)
* create src/component/loginform.jsx
  * form>(div.form-group>label+input.form-control[type="email"][id="a"]+small.form-text.text-muted)*2
* loginform.jsx
  * for change to htmlFor
  * class change to className

```js
import React, { Component } from "react";
class LoginForm extends React.Component {
  render() {
    return (
      <form>
        <div className="form-group">
          <label htmlFor="username">username</label>
          <input type="text" className="form-control" id="username" />
        </div>
        <div className="form-group">
          <label htmlFor="password">Password</label>
          <input type="password" className="form-control" id="password" />
        </div>
        <button type="submit" className="btn btn-primary">
          Login
        </button>
      </form>
    );
  }
}

export default LoginForm;
```

### 3 - Handling Form submission

* loginform.jsx

```js
...
  handleSubmit = (e) => {
    e.preventDefault();// prevent default behavior - i.e. submitting the form
    console.log("handleSubmit");
  };
  ...
      <form onSubmit={this.handleSubmit}>
 ...
        <button className="btn btn-primary">Login</button>
      </form>
```

### 4 - Refs

* in replace of document.getElementById
* use sparingly

```js
username = React.createRef();
...
console.log(this.username.current.value);
```

### 5 - Controlled Elements

* keep the input value in sync with state
  * create state
  * create method to sync form and state
  * call onchange and set value using state

```jsx
...
  state = {
    account: { username: "", password: "" },
  };
...
  handleChange = (e) => {
    const account = { ...this.state.account };
    account.username = e.currentTarget.value;
    this.setState({ account });
  };
...
           <input
...
              onChange={this.handleChange}
              value={this.state.account.username}
            />
            ...
```

### 6 - handling multiple input

* loginform.jsx

```jsx
...
  handleChange = (e) => {
    ... 
    account[e.currentTarget.name] = e.currentTarget.value;
    ...
  };
  ...
            <input
              ...
              name="username"
              onChange={this.handleChange}
              value={this.state.account.username}
            />
...
              name="password"
              value={this.state.account.password}
              onChange={this.handleChange}
```

### 7 - Common Errors

* controlled element state properties value cannot be null or undefined

### 8 - Extracting a resuable input

* create input.jsx

```jsx
import React from "react";
class Input extends React.Component {
  render() {
    const { name, type, label, value, handleChange } = this.props;

    return (
      <div className="form-group">
        <label htmlFor={name}>{label}</label>
        <input
          autoFocus
          type={type}
          className="form-control"
          id={name}
          name={name}
          onChange={handleChange}
          value={value}
        />
      </div>
    );
  }
}

export default Input;
```

* loginform.jsx
  * import and use input.jsx

```jsx
import Input from "./common/input";
...
          <Input
            name="username"
            type="text"
            handleChange={this.handleChange}
            value={this.state.account.username}
            label="Username"
          />
          <Input
            name="password"
            type="password"
            handleChange={this.handleChange}
            value={this.state.account.password}
            label="Password"
          />
```

### 9,10 - Validation/Basic validation implementation

* loginform.jsx
  * inject errors in errors object and return

```jsx
...
  validate() {
    let errors = {};
    if (this.state.account.username.trim() === "")
      errors.username = "username is required";
    if (this.state.account.password.trim() === "")
      errors.password = "password is required";

    return Object.keys(errors).length === 0 ? null : errors;
  }
  handleSubmit = (e) => {
    e.preventDefault();

    const errors = this.validate();
    console.log(errors);
    this.setState({ errors });
    if (errors) return;

    console.log("submitted");
  };
  ...
```

### 11 - Display validation errors

* loginform.jsx
  * add error object for each field into state.errors during validation
  * passed error object to input

```jsx
  ...
  handleSubmit = (e) => {
...
    this.setState({ errors: errors || {} }); // errors must always be not null
    ...
  };
  ...
          <Input
            name="username"
            ...
            error={this.state.errors["username"]}
          />
          <Input
            name="password"
            ...
            error={this.state.errors["password"]}
          />
```

* input.jsx
  
```jsx
...
{error && <div className="alert alert-danger">{error}</div>} // show when "error" is not null
...
```

### 12 - validation on change

* input.jsx
  * validation upon change
  * set error to state and update view
* loginform.jsx

```jsx
...
  validateInput = (currentTarget) => {
    if (currentTarget.value.trim() === "")
      return currentTarget.name + " cannot be empty";
    return null;
  };
  handleChange = (e) => {
    let errorMessage = this.validateInput(e.currentTarget);
    let errors = {};
    errors[e.currentTarget.name] = errorMessage;
    const account = { ...this.state.account };
    account[e.currentTarget.name] = e.currentTarget.value;
    this.setState({ account, errors });
  };
  ...
```

### 13/14 - Joi/Validating a form using joi

* install joi
  * npm i joi-browser@13.4
* loginform.jsx
  * import Joi
  * define schema
  * validate using joi
  * construct errors and refresh ui

```jsx
...
import Joi from "joi-browser";
...
  schema = {
    username: Joi.string().required().label("User Name"),
    password: Joi.string().min(8).required().label("Password"),
  };
...
  validate() {
    let results = Joi.validate(this.state.account, this.schema, {
      abortEarly: false,
    });
    if (!results.error) return null;

    let errors = {};
    for (let item of results.error.details) errors[item.path[0]] = item.message;

    return errors;
  }
  ...
```

### 15 - Validatng a Property

* loginform.jsx
  * validate only the speicfic field using specific schema

```jsx
...
  validateInput = (currentTarget) => {
    let name = currentTarget.name;
    let value = currentTarget.value;
    let property = { [name]: value };
    let schema = { [name]: this.schema[name] };
    let results = Joi.validate(property, schema);
    if (results.error) return results.error.details[0].message;
    return null;
  };
...
```

### 16 - Disabling the submit button

* loginform.jsx
  * call validate to check disabled or not
    * null is considered falsy
    * not-null is considered truthy

```jsx
...
<button disabled={this.validate()} className="btn btn-primary">
...
```

### 17/18 - Code Review/Extracting A Resuable Form

* common/form.jsx
  * extract resuable componebt from loginform.jsx and put here

```jsx
import React from "react";
import Joi from "joi-browser";
class Form extends React.Component {
  state = {
    data: {},
    errors: {},
  };

  validate() {
    let results = Joi.validate(this.state.data, this.schema, {
      abortEarly: false,
    });
    if (!results.error) return null;

    let errors = {};
    for (let item of results.error.details) errors[item.path[0]] = item.message;

    return errors;
  }

  validateInput = (currentTarget) => {
    let name = currentTarget.name;
    let value = currentTarget.value;
    let property = { [name]: value };
    let schema = { [name]: this.schema[name] };
    let results = Joi.validate(property, schema);
    if (results.error) return results.error.details[0].message;
    return null;
  };

  handleSubmit = (e) => {
    e.preventDefault();

    const errors = this.validate();
    this.setState({ errors: errors || {} });
    if (errors) return;

    this.doSubmit();
  };

  handleChange = (e) => {
    let errorMessage = this.validateInput(e.currentTarget);
    let errors = {};
    errors[e.currentTarget.name] = errorMessage;
    const data = { ...this.state.data };
    data[e.currentTarget.name] = e.currentTarget.value;
    this.setState({ data, errors });
  };
}

export default Form;
```

* loginform.jsx
  * import form.jsx and extend it

```jsx
import React from "react";
import Input from "./common/input";
import Joi from "joi-browser";
import Form from "./common/form";
class LoginForm extends Form {
  state = {
    data: { username: "", password: "" },
    errors: {},
  };

  schema = {
    username: Joi.string().required().label("User Name"),
    password: Joi.string().min(8).required().label("Password"),
  };

  doSubmit = () => {
    console.log("submitted");
  };

  render() {
    return (
      <div>
        <h1>Login</h1>
        <form onSubmit={this.handleSubmit}>
          <Input
            name="username"
            type="text"
            handleChange={this.handleChange}
            value={this.state.data.username}
            label="Username"
            error={this.state.errors["username"]}
          />
          <Input
            name="password"
            type="password"
            handleChange={this.handleChange}
            value={this.state.data.password}
            label="Password"
            error={this.state.errors["password"]}
          />

          <button disabled={this.validate()} className="btn btn-primary">
            Login
          </button>
        </form>
      </div>
    );
  }
}

export default LoginForm;
```

### 19 - extracting helper rendering methods

* form.jsx

```jsx
...
  renderButton(label) {
    return (
      <button disabled={this.validate()} className="btn btn-primary">
        {label}
      </button>
    );
  }

  renderInput(name, label, type, value) {
    return (
      <Input
        label={label}
        name={name}
        type={type}
        value={value}
        handleChange={this.handleChange}
        error={this.state.errors[name]}
      />
    );
  }
  ...
```

* loginform.jsx

```jsx
...
          {this.renderInput(
            "username",
            "Username",
            "text",
            this.state.data.username
          )}
          {this.renderInput(
            "password",
            "Password",
            "password",
            this.state.data.password
          )}

          {this.renderButton("Login")}
          ...
```

### 20, 21 - register form/Code Review

* create register form with (/register)
  * username
    * email
    * required
    * not null
  * password
    * password type
    * min 5
    * required
  * name
    * required
  * register
    * button
    * disable if got valudation errors

```jsx
import React from "react";
import Form from "./common/form";
import Joi from "joi-browser";
class RegisterForm extends Form {
  state = {
    data: { username: "", password: "", name: "" },
    errors: {},
  };

  schema = {
    username: Joi.string().email().required().label("User Name"),
    password: Joi.string().min(5).required().label("Password"),
    name: Joi.string().min(8).required().label("Name"),
  };

  doSubmit = () => {
    console.log("submitted");
  };

  render = () => {
    return (
      <div>
        <h1>Register</h1>
        <form onSubmit={this.handleSubmit}>
          {this.renderInput(
            "username",
            "Username",
            "text",
            this.state.data.username,
            "true"
          )}
          {this.renderInput(
            "password",
            "Password",
            "password",
            this.state.data.password,
            "false"
          )}
          {this.renderInput(
            "name",
            "Name",
            "text",
            this.state.data.name,
            "false"
          )}
          {this.renderButton("Login")}
        </form>
      </div>
    );
  };
}

export default RegisterForm;
```

* App.js

```js
...
import RegisterForm from "./components/registerform";
...
{ link: "/register", label: "Register" },
...
<Route path="/register" component={RegisterForm} />
...
```

### 22, 23 - Exercuse 2 - Movie Form/Code Review

* movies.jsx
  * movie (button)
    * movieform.jsx
      * title - done
        * string - done
      * genre
        * dropdown - done
          * onClick - done
      * stock
        * number - done
        * 0 - 10 - done
      * rate
        * number - done
        * 1 - 10 - done
      * add (button)
        * add to list
        * return the movies page
  * invalid movie link
    * 404
  * delete (button)
    * refresh the list
* App.js

```js
...
import MovieForm from "./components/movieform";
...
<Route path="/movieform/new" component={MovieForm} />
...
```

* movies.jsx

```jsx
...
  addMovie = () => {
    this.props.history.push("/movieform/new");
  };
  ...
          <button className="btn btn-primary" onClick={this.addMovie}>
            new movie
          </button>
          ...
```

* movieform.jsx

```jsx
...
import { getGenres } from "../services/fakeGenreService";
import { getMovies, saveMovie } from "../services/fakeMovieService";
...
  state = {
    data: {
      _id: "",
      title: "",
      genreId: {},
      numberInStock: "",
      dailyRentalRate: "",
    },
    errors: {},
    genres: [],
  };
  schema = {
    _id: Joi.string(),
    title: Joi.string().min(1).required().label("Title"),
    genreId: Joi.string().required().label("Genre"),
    numberInStock: Joi.number().min(1).max(100).required().label("Stock"),
    dailyRentalRate: Joi.number().min(1).max(10).required().label("Rate"),
  };
  ...
  componentDidMount() {
    let genres = [...getGenres()];
    let data = {
      _id: Date.now().toString(),
      title: "",
      genreId: {},
      numberInStock: "",
      dailyRentalRate: "",
    };
    if (this.props.match.params.movieid) {
      let movies = getMovies();
      data = this.mapToViewModel(
        movies.filter((m) => m._id === this.props.match.params.movieid)[0]
      );
    }
    this.setState({ data, genres });
  }
  doSubmit = (movie) => {
    saveMovie(movie);
    this.props.history.replace("/movies");
  };
  ...
            {this.renderDropdown(
            "genreId",
            "Genre",
            this.state.genres,
            this.state.data.genreId
          )}
          ...

```

* form.jsx

```jsx
...
import Dropdown from "./dropdown";
...
  renderDropdown(name, label, options, value) {
    const { errors } = this.state;
    return (
      <Dropdown
        options={options}
        value={value}
        name={name}
        label={label}
        handleChange={this.handleChange}
        error={errors[name]}
      />
    );
  }
...
```

* dropdown.jsx

```jsx
import React from "react";
class Dropdown extends React.Component {
  handleChange = (e) => {
    this.props.handleChange(e);
  };
  render = () => {
    const { name, label, options, error, value } = this.props;
    return (
      <div className="form-group">
        <label htmlFor={name}>{label}</label>
        <select
          name={name}
          id={name}
          className="form-control"
          onChange={this.handleChange}
          value={value}
        >
          <option value=""></option>
          {options.map((option) => (
            <option key={option._id} value={option._id}>
              {option.name}
            </option>
          ))}
        </select>
        {error && <div className="alert alert-danger">{error}</div>}
      </div>
    );
  };
}

export default Dropdown;
```

### 24/25 - Exercise 3 - Search Movies/Code Review

* search box
  * type and refresh
* case insensitive
* ignore filter
  * either filter or search
* searchbox.jsx

```jsx
import React from "react";
class SearchBox extends React.Component {
  handleSearch = (e) => {
    this.props.handleSearch(e.currentTarget.value);
  };
  render() {
    const { value } = this.props;
    return (
      <div class="form-group">
        <input
          type="text"
          class="form-control"
          id="search"
          aria-describedby="search"
          placeholder="search"
          value={value}
          onChange={this.handleSearch}
        />
      </div>
    );
  }
}

export default SearchBox;
```

* movies.jsx

```jsx
...
import SearchBox from "./common/searchbox";
...
  handleFilterGenre = (selectedGenre) => {
    let movies = getMovies();
    this.setState({ selectedGenre, currentPage: 1, movies, search: "" });
  };
...
  handleSearch = (value) => {
    let movies = getMovies().filter(
      (m) => m.title.toLowerCase().indexOf(value.toLowerCase()) > -1
    );

    this.setState({
      selectedGenre: { _id: "all", name: "All Genres" },
      currentPage: 1,
      movies: movies,
      search: value,
    });
  };
...
          <SearchBox
            handleSearch={this.handleSearch}
            value={this.state.search}
          />
          ...
```