---
layout: single
# classes: wide
title:  "React - Calling backend Services"
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

## Calling backend Services

### 1/2 - Introducetion/JSON Placeholder

* download Section 8- Calling Backend Services.zip
* cd http-app
* npm i
* npm start
* fake api
  * <https://jsonplaceholder.typicode.com/>

### 3 - HttpClients

* modern browser supports
  * fetch api
  * jquery ajax
  * axios (this project)
* install axios
  * npm i axios@0.18
* Promise
  * object that is returned by api (since is async, api will "promise" to return a object once ready)

### 4 - getting data

* most api is async(doesnt' get results on the spot)
  * decorate method with "async"
  * add "await" to method invocation
    * TLDR
      * line will only resume when results is back (doesn't matter what's the function log. e.g. calling api with another async)
    * Long version

```txt
The await expression causes async function execution to pause until a Promise is settled (that is, fulfilled or rejected), and to resume execution of the async function after fulfillment. When resumed, the value of the await expression is that of the fulfilled Promise.

If the Promise is rejected, the await expression throws the rejected value.
```

* App.jsx

```jsx
...
async componentDidMount() {}
...
    const { data: posts } = await http.get(config.apiEndpoint);
    this.setState({ posts });
    ...
```

### 5 - Creating Data

```jsx
...
  handleAdd = async () => {
    const obj = { title: "a", body: "b" };
    const { data: post } = await http.post(config.apiEndpoint, obj);

    const posts = [post, ...this.state.posts];
    this.setState({ posts });
  };
  ...
```

### 6 - Lifecycle of a request

* method will be change to "OPTION" when "get" source and target is different (browsesr behavior)

### 7 - Updating Data

```jsx
...
  handleUpdate = async (post) => {
    post.title = "UPDATED";
    await http.put(config.apiEndpoint + "/" + post.id, post);

    const posts = [...this.state.posts];
    const index = posts.indexOf(post);
    posts[index] = { ...post };
    this.setState({ posts });
  };
  ...
```

### 8 - Delete Data

```jsx
...
  handleDelete = async (post) => {
    const originalPosts = this.state.posts;

    const posts = this.state.posts.filter((p) => p.id !== post.id);
    this.setState({ posts });
  };
...
```

### 9 - Optimistic vs Perssimistic updates

* Pessimistic
  * call api followed by update
    * there will be latency when calling api, that's why UI looks hanging (0.5s) before the object is added/removed/updated

```jsx
...
  handleDelete = async (post) => {
    await http.delete(config.apiEndpoint + "/" + post.id);
    // wait for 0.5s
    const posts = this.state.posts.filter((p) => p.id !== post.id);
    this.setState({ posts });

  };
  ...
```

* Optimistic
  * update UI first then call api. Revert UI if got error.

```jsx
...
  handleDelete = async (post) => {
    const originalPosts = this.state.posts;

    const posts = this.state.posts.filter((p) => p.id !== post.id);
    this.setState({ posts });

    try {
      await http.delete(config.apiEndpoint + "/" + post.id);
    } catch (ex) {
      if (ex.response && ex.response.status === 404)
        alert("This post has already been deleted.");
      this.setState({ posts: originalPosts });
    }
  };
...
```

### 10 - Expected vs Unexpected Errors

* Expeceed
  * 400 - 500
    * E.g.
      * 404 - not found
      * 400 - bad request
  * client error
  * display specic error message
* unexpected
  * E.g.
    * daatbase down
    * network down
  * log them
  * display a generic and freindly error message

```jsx
...
  handleDelete = async (post) => {
    ...
    try {
      await http.delete(config.apiEndpoint + "/" + post.id);
    } catch (ex) {
      if (ex.response && ex.response.status === 404)
        alert("This post has already been deleted.");
      this.setState({ posts: originalPosts });
    }
  };
...
```

### 11 - Unhandling Unexpected Errors Globally

* use axios intercepters
  * intercept request before going out
  * intercept success response or failure response(expected and unexpected) before returning to client (i.e. catch(e))
    * E.g.
      * axios.interceptors.response.use(success function, error => {... error.response.status ... return Promise.reject(error)...} )

```jsx
...
axios.interceptors.response.use(null, error => {
  const expectedError =
    error.response &&
    error.response.status >= 400 &&
    error.response.status < 500;

  if (!expectedError) {
    logger.log(error);
    toast.error("An unexpected error occurrred.");
  }

  return Promise.reject(error);
});
...
```

### 12 - Extracting a Reusable Http Service

* create a reusnable service
  * copy intercept code
* create src/services/httpService.js

```js
import axios from "axios";
import logger from "./logService";
import { toast } from "react-toastify";

axios.interceptors.response.use(null, error => {
  const expectedError =
    error.response &&
    error.response.status >= 400 &&
    error.response.status < 500;

  if (!expectedError) {
    logger.log(error);
    toast.error("An unexpected error occurrred.");
  }

  return Promise.reject(error);
});

export default {
  get: axios.get,
  post: axios.post,
  put: axios.put,
  delete: axios.delete
};
```

* app.js
  * import and use (change all occurances of "axio." to "http.")

```js
...
import http from "./services/httpService";
...
const { data: posts } = await http.get(config.apiEndpoint);
...
```

### 13 - Extracting a config module

* put all config into another file
* src/config.json
  * move all config to config.json as object

```json
{
  "apiEndpoint": "https://jsonplaceholder.typicode.com/posts"
}
```

* app.js
  * improt and use

```js
...
import config from "./config.json";
...
const { data: posts } = await http.get(config.apiEndpoint);
...
```

### 14 - Displaying Toast Notifications

* in replace of ugly alert
* install
  * npm i react-toastify@4.1
* App.js
  * import component, css and use

```js
...
import { ToastContainer } from "react-toastify";
...
import "react-toastify/dist/ReactToastify.css";
...

  render() {
    return (
...
        <ToastContainer />
        ...
```

* httpService.js
  * import and use
    * replace alert with toast or toast.error

```js
...
import { toast } from "react-toastify";
...
toast.error("An unexpected error occurrred.");
...
```

### 15 - Logging Errors

* "console.log" is browser, developer won't know. Hence have to log to server
  * E.g. sentry.io
    * signup using <http://programmingwithmosh.com/tools>
    * create an new app under react
    * copy the code from setup guide and modify index.js
* install
  * ~~npm i raven-js@3.26.4~~
  * npm install --save @sentry/react @sentry/tracing
* index.js

```js
...
import * as Sentry from "@sentry/react";
import { Integrations } from "@sentry/tracing";
...
Sentry.init({
  dsn: "...",
  integrations: [new Integrations.BrowserTracing()],

  // Set tracesSampleRate to 1.0 to capture 100%
  // of transactions for performance monitoring.
  // We recommend adjusting this value in production
  tracesSampleRate: 1.0,
});
...
```

### 16 - Extracting a logger service

* externalize logger setup in another module
  * so that can change to different library later
* index.js

```js
...
import logger from "./services/logService";
...
logger.init();
...
```

* service/logService.js

```js
import * as Sentry from "@sentry/react";
import { Integrations } from "@sentry/tracing";

function init() {
  // Raven.config("ADD YOUR OWN API KEY", {
  //   release: "1-0-0",
  //   environment: "development-test"
  // }).install();
  Sentry.init({
    dsn: "https://3c19e07221c1496fb666f4c16ea5b692@o1072694.ingest.sentry.io/6071973",
    integrations: [new Integrations.BrowserTracing()],

    // Set tracesSampleRate to 1.0 to capture 100%
    // of transactions for performance monitoring.
    // We recommend adjusting this value in production
    tracesSampleRate: 1.0,
  });
}

function log(error) {
  // Raven.captureException(error);
}

export default {
  init,
  log,
};
```

### 17 - Vidly Backend

* backend
  * node > express > mongodb
    * node is library to run javascript outside of browser
    * express is framework to build rest api
    * mongodb is db

### 18 - setup mongodb in mac

* not related

### 19 - setup mongodb in windows

* download from <https://www.mongodb.com/try/download/community>
* install
  * as service
    * mongodb
    * mongodb compass
      * UI to access mongodb
* install
  * as program
    * create c:\data\db
    * set PATH to mongodb/bin
    * run as mongod
* run mongodb compass@localhost:27017

### 20 - setting up the node backend

* download git project from <https://github.com/mosh-hamedani/vidly-api-node>
* clone the project
  * git clone https://github.com/mosh-hamedani/vidly-api-node.git
* cd vidly-api-node
* npm i
* npm uninstall bcrypt --save
* npm install bcrypt@5 --save
* node seed.js
* open mongodb compass
  * select vidly database
* start backedn
  * node index.js
* visit <http://localhost:3900/api/movies>

### 21 - Disabling Authentication

* vidly-api-node
  * disable
* config/default.json

```json
...
{
  ...
  "requiresAuth": false
}
...
```

### 22/23/24/25/26/27/28/29 - Exercise - Connect Movies Page to the Backend

#### Requirement

* modify vidly app to read from real database

#### Steps

* install sentry
  * npm install --save @sentry/react @sentry/tracing
* install axios
  * npm i axios@0.18
* install toastify
  * npm i react-toastify@4.1
* copy http-app/src/service/logService.js to vidly-app/src/service/
* copy http-app/src/service/httpService.js to vidly-app/src/service/
* create src/service/genreService.js

```js
import http from "./httpService";
import config from "../config.json";
export function getGenres() {
  let data = http.get(config.genreEndpoint);
  return data;
}
```

* src/service/movieService.js
* App.js

```js
...
import { ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
...
```

* httpService.js

```js
import axios from "axios";
import logger from "./logService";
import { toast } from "react-toastify";

axios.interceptors.response.use(null, (error) => {
  const expectedError =
    error.response &&
    error.response.status >= 400 &&
    error.response.status < 500;

  if (!expectedError) {
    logger.log(error);
    toast.error("An unexpected error occurrred.");
  }

  return Promise.reject(error);
});

export default {
  get: axios.get,
  post: axios.post,
  put: axios.put,
  delete: axios.delete,
};
```

* movies.js

```jsx
...
import { getGenres } from "../services/genreService";
...
import { ToastContainer } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
...
  async componentDidMount() {
    let { data } = await getGenres();
    this.setState({
      ...
      genres: [{ _id: "all", name: "All Genres" }, ...data],
    });
  }
...
  async componentDidMount() {
    let { data: movies } = await getMovies();
    let { data: genres } = await getGenres();
...
  }
  ...

```

* movieService.js

```js
import * as genresAPI from "./genreService";

import http from "./httpService";
import config from "../config.json";

export function getMovies() {
  return http.get(config.movieEndpoint);
}

export async function getMovie(id) {
  let { data: movies } = await getMovies();
  return await movies.find((m) => m._id === id);
}

export async function saveMovie(movie) {
  let body = { ...movie };
  if (body._id) {
    delete body._id;
    const { data: newMovieInDb } = await http.put(
      config.movieEndpoint + "/" + movie._id,
      body
    );
    return newMovieInDb;
  }
  delete body._id;
  const { data: newMovieInDb } = await http.post(config.movieEndpoint, body);
  return newMovieInDb;
}

export function deleteMovie(id) {
  return http.delete(config.movieEndpoint + "/" + id);
}
```

* movieForm.jsx
  * point to new service
  * implement async+await

```jsx
...
import { getGenres } from "../services/genreService";
import { getMovies, saveMovie } from "../services/movieService";
...
  schema = {
    _id: Joi.string().allow(""),
...
  async componentDidMount() {
    let { data: genres } = await getGenres();
...
    let { data: movies } = await getMovies();
...
  doSubmit = async (movie) => {
    try {
      await saveMovie(movie);
    } catch (ex) {
      if (ex.response && ex.response.status === 400) {
        console.log(ex.response);
        toast.error("error while saving " + ex.response.data);
      }
    }
    ...
  };
  ...
  };
...
```

* movies.jsx

```jsx
...
import { getMovies, deleteMovie } from "../services/movieService";
import { getGenres } from "../services/genreService";
...
import { toast } from "react-toastify";
class Movies extends React.Component {
...
  async componentDidMount() {
    let { data: movies } = await getMovies();
    let { data: genres } = await getGenres();
    this.setState({
      movies,
      genres: [{ _id: "all", name: "All Genres" }, ...genres],
    });
  }
  handleDelete = async (movie) => {
    try {
      movie = await deleteMovie(movie._id);
    } catch (ex) {
      if (ex.response && ex.response.status === 404) {
        toast.error("movie has already been deleted");
      }
    }
    let { data: movies } = await getMovies();
    this.setState({ movies, currentPage: 1 });
  };
...
  handleFilterGenre = async (selectedGenre) => {
    let { data: movies } = await getMovies();
    ...
  };
...
  handleSearch = async (value) => {
    let { data: movies } = await getMovies();
...
  };
...
```

### 30 - Refactor

* remove fakeGenreService.js
* remove fakeMovieService.js