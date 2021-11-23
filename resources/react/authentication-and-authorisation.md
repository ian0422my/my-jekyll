---
layout: single
# classes: wide
title:  "React - Authentication and Authorisation"
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

## Authentication and Authorisation

### 2 - Registering a new user

* POST http://localhost:3900/api/users

### 3/4 - Submiting the registration form/handling registration error

* services/userService.js

```js
import http from "./httpService";
import config from "../config.json";
export function register(user) {
  return http.post(config.userEndpoint, {
    email: user.username,
    password: user.password,
    name: user.name,
  });
}
```

* registerform.jsx

```jsx
...
import { toast } from "react-toastify";
import * as userService from "../services/userService";
class RegisterForm extends Form {
...
  doSubmit = async (data) => {
    try {
      let user = await userService.register(data);
    } catch (ex) {
      if (ex.response && ex.response.status === 400) {
        toast.error(ex.response.data);
      }

      this.props.history.replace("/");
    }
  };
...
```

### 5 - loggin in a user

* POST /api/auth
  * body
    * {email,password}
  * retun jwt
    * can be used for all authenticated api

### 6/7 - submitting to login form/hablding login errors

* loginform.jsx

```jsx
...
import * as authService from "../services/authService";
class LoginForm extends Form {
 ...
  doSubmit = async (data) => {
    try {
      const { data: jwt } = await authService.login(
        data.username,
        data.password
      );
    } catch (ex) {
      if (ex.response && ex.response.status === 400) {
        let errors = { ...this.state.errors };
        errors.username = ex.response.data;
        this.setState({ errors });
      }
    }
  };
...
```

### 8 - Storing JWT

* store jwt into browser
  * local storage
    * kvp
* loginform.jsx

```jsx
...
      localStorage.setItem("token", jwt);
      this.props.history.replace("/");
...
```

### 9 - logging in the user upon registration

* vidly-api-node
  * route/user.js
    * whitelist custom token "x-auth-token" so that it can be seen from browser

```js
...
.header("access-control-expose-headers", "x-auth-token")
...
```

* registerform.jsx

```jsx
...
localStorage.setItem("token", response.headers["x-auth-token"]);
...
this.props.history.replace("/");
...
```

### 10 - what is JWT?

* 3 sections
  * header
  * payload/claims
  * digital signature of
    * header
    * payload
    * secret/private key of the server
* copy token frmo browser > inspect element > application > local storage > token
* goto <https://jwt.io>
  * go o debugger
  * paste token value
    * header
    * payload

### 11 - getting the current user (from jwt)

* npm i jwt-decode@2.2.0
* App.js

```js
...
import jwtDecode from "jwt-decode";
...
  componentDidMount() {
    try {
      const jwt = localStorage.getItem("token");
      const user = jwtDecode(jwt);
      this.setState({ user });
    } catch (error) {}
  }
...
```

### 12 - Display the current user on navbar

* menu
  * after login redurect to homepage
  * if login
    * don't show login/register
    * show profile/logout button
  * if not login
    * show login/register
    * don't show profile/logout button
* App.js

```js
...
      { link: "/profile", label: "Profile", secure: true },
      { link: "/login", label: "Login", secure: false },
      { link: "/register", label: "Register", secure: false },
      { link: "/logout", label: "Logout", secure: true },
      ...
  componentDidMount() {
    try {
      const jwt = localStorage.getItem("token");
      const user = jwtDecode(jwt);
      this.setState({ user });
    } catch (error) {}
  }
  ...
            <Route path="/register" component={RegisterForm} />
          <Route path="/login" component={LoginForm} />
          <Route path="/logout" component={LogoutForm} />
          ...
```

* loginform.jsx

```jsx
...
      localStorage.setItem("token", jwt);
      window.location = "/";
...
```

* registerform.jsx

```jsx
...
      localStorage.setItem("token", response.headers["x-auth-token"]);
      window.location = "/";
...
```

### 13 - logging out a user

* logoutform.jsx

```jsx
import React from "react";
class LogoutForm extends React.Component {
  componentDidMount() {
    localStorage.removeItem("token");
    window.location = "/login";
  }

  render() {
    return null;
  }
}

export default LogoutForm;
```

### 14 - Refactoring

* move localStorage related code to auth service
* create function
  * login(username, password)
  * loginWithJWT(jwt)
  * logout
* authservice.js

```js
import http from "./httpService";
import config from "../config.json";

const tokenKey = "token";
async function login(username, password) {
  const { data: jwt } = await http.post(config.authEndpoint, {
    email: username,
    password,
  });
  localStorage.setItem(tokenKey, jwt);

  return jwt;
}

function logout() {
  localStorage.removeItem(tokenKey);
}

function loginWithJWT(jwt) {
  localStorage.setItem(tokenKey, jwt);
}

export default { login, logout, loginWithJWT };import http from "./httpService";
import jwtDecode from "jwt-decode";
import config from "../config.json";

const tokenKey = "token";
async function login(username, password) {
  const { data: jwt } = await http.post(config.authEndpoint, {
    email: username,
    password,
  });
  localStorage.setItem(tokenKey, jwt);

  return jwt;
}

function logout() {
  localStorage.removeItem(tokenKey);
}

function loginWithJWT(jwt) {
  localStorage.setItem(tokenKey, jwt);
}

function getCurrentUser() {
  const jwt = localStorage.getItem("token");
  const user = jwtDecode(jwt);

  return user;
}

export default { login, logout, loginWithJWT, getCurrentUser };
import http from "./httpService";
import jwtDecode from "jwt-decode";
import config from "../config.json";

const tokenKey = "token";
async function login(username, password) {
  const { data: jwt } = await http.post(config.authEndpoint, {
    email: username,
    password,
  });
  localStorage.setItem(tokenKey, jwt);

  return jwt;
}

function logout() {
  localStorage.removeItem(tokenKey);
}

function loginWithJWT(jwt) {
  localStorage.setItem(tokenKey, jwt);
}

function getCurrentUser() {
  const jwt = localStorage.getItem("token");
  const user = jwtDecode(jwt);

  return user;
}

export default { login, logout, loginWithJWT, getCurrentUser };
import http from "./httpService";
import jwtDecode from "jwt-decode";
import config from "../config.json";

const tokenKey = "token";
async function login(username, password) {
  const { data: jwt } = await http.post(config.authEndpoint, {
    email: username,
    password,
  });
  localStorage.setItem(tokenKey, jwt);

  return jwt;
}

function logout() {
  localStorage.removeItem(tokenKey);
}

function loginWithJWT(jwt) {
  localStorage.setItem(tokenKey, jwt);
}

function getCurrentUser() {
  const jwt = localStorage.getItem("token");
  const user = jwtDecode(jwt);

  return user;
}

export default { login, logout, loginWithJWT, getCurrentUser };import http from "./httpService";
import jwtDecode from "jwt-decode";
import config from "../config.json";

const tokenKey = "token";
async function login(username, password) {
  const { data: jwt } = await http.post(config.authEndpoint, {
    email: username,
    password,
  });
  localStorage.setItem(tokenKey, jwt);

  return jwt;
}

function logout() {
  localStorage.removeItem(tokenKey);
}

function loginWithJWT(jwt) {
  localStorage.setItem(tokenKey, jwt);
}

function getCurrentUser() {
  const jwt = localStorage.getItem("token");
  const user = jwtDecode(jwt);

  return user;
}

export default { login, logout, loginWithJWT, getCurrentUser };
```

* loginform.jsx

```jsx
...
import authService from "../services/authService";
...
      const { data: jwt } = await authService.login(
        data.username,
        data.password
      );
      //ocalStorage.setItem("token", jwt);
      window.location = "/";
...
```

* registerform.jsx

```jsx
...
import authService from "../services/authService";
...
authService.loginWithJWT(response.headers["x-auth-token"]);
...
```

* logoutform.jsx

```jsx
...
import authService from "../services/authService";
...
    authService.logout();
...
```

* App.js

```js
...
import authService from "./services/authService";
...
const user = authService.getCurrentUser();
...
```

### 15 - calling protected api

* include x-auth-token:jwt for all api
  * vidly-api-node/config/default.json
    * requiresAuth: true
    * restart
  * httpService.js

```js
...
import authService from "./authService";

axios.defaults.headers.common["x-auth-token"] = authService.getJWT();
...
```

### 16 - fixing bidirectional dependencies

* authService and httpService has interdependant dependencies
  * since httpService is more important, httpService should not have dependencies on auth
    * so, httpService cannot authService.getJWT -> authService will httpService.setJWT
      * reverse
* httpService.js

```js
...
// import authService from "./authService";

//axios.defaults.headers.common["x-auth-token"] = authService.getJWT();
...
function setJWT(jwt) {
  axios.defaults.headers.common["x-auth-token"] = jwt;
}

export default {
  ...
  setJWT,
};
...
```

* authService.js

```js...
import httpService from "./httpService";
...
httpService.setJWT(getJWT());
```

### - Authorization