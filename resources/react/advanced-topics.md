---
layout: single
#classes: wide
title:  "React - Advanced Topics"
date:   2021-12-01 16:00:50 +0800
categories: react
allow_different_nesting: true
sidebar:
  nav: "react"
---

## Advanced Topics

### 3 - setting up the development environent

* download the latest node
* use npx to create app (will not install create-react-app in global space)

```cmd
npx create-react-app react-advanced
```

### 4 - higher order components (HOC)

* to wrap around all components within a common components (with common functionally)

### 5 - implementing a higher order component

* create wrapper component with
  * event handler to set state
  * pass all props from original component into wrapper component (i.e. {...this.props})
* wrap original components with a wrapper components
* pass all props to the wrapper component
* implement the ui with state
* withTooltip.jsx

```jsx
import React from "react";

export default function withTooltip(Component) {
  return class WithTooltip extends React.Component {
    state = {
      showTooltip: false,
    };

    handleMouseOver = () => {
      this.setState({ showTooltip: true });
    };

    handleMouseOut = () => {
      this.setState({ showTooltip: false });
    };

    render() {
      return (
        <div
          onMouseOver={this.handleMouseOver}
          onMouseOut={this.handleMouseOut}
        >
          <Component showTooltip={this.state.showTooltip} {...this.props} />
        </div>
      );
    }
  };
}
```

* movie.jsx

```jsx
import React from "react";
import withTooltip from "./withTooltip";
class Movie extends React.Component {
  render() {
    return <div>movies{this.props.showTooltip && "some tooltip"}</div>;
  }
}

export default withTooltip(Movie);
```

### 6 - hooks

* react 16.8 onwards, we can use state in FC
  * im other words, FC is no more stateless
* FC code is cleaner and will behave just like class component
* new hook
  * useState
  * useEffect
  * useContext

### 7 - useState

* syntax

```jsx
const [var, setState] = useState(var's inititial value);
```

* same effect as setState in cc
* can be called multiple times
  * variables are stored in sequence internally in the memeory
    * that's why setState cannot be called conditionally (loop, if/else, while loop)
* must call before can use
* hooks/Counters.jsx

```jsx
import React, { useState } from "react";

export default function Counter(props) {
  var [count, setCount] = useState(0);
  var [name, setName] = useState("");

  return (
    <React.Fragment>
      <input onChange={(e) => setName(e.currentTarget.value)}></input>
      <div>
        {name} has clicked {count} times
      </div>
      <button onClick={() => setCount(count + 1)}>increase</button>
    </React.Fragment>
  );
}
```

### 8 - useEffect

* in class component, rendering logic is spread to all lifecycle hook. in SFC, useEffect will solve that problem (i.e. only 1 set of code is needed)
  * equivalent of class components
    * componentDidMount
    * componentDidUpdate
    * compomentWillUnmount
* function will only be called
  * after DOM is render
  * if dependency arrays value changes (if specified)
* syntax
  * useEffect(function, [dependency arrays])
    * function will handle componentDidMount+componentDidUpdate
      * dependency arrays
        * function will call if value changes for dependency array <https://reactjs.org/docs/hooks-effect.html#tip-optimizing-performance-by-skipping-effects>
    * return function will handle compomentWillUnmount
  * E.g.
    * useEffect(function) - always call
    * useEffect(function, []) - call when mount, unmount
      * mount
        * null <> empty array
      * unmount
        * empty array <> null
* Counter.jsx

```jsx
import React, { useState, useEffect } from "react";
...
  useEffect(() => {
    document.title = name + " has clicked " + count + " times!";

    return () => {
      console.log("clean up");
    };
  }, [name, count]);
...
```

### 9 - Custom Hooks

* move all common logic from hooks to a custom hook
* hooks/useDocumentTitle.js

```js
import { useEffect } from "react";
export default function useDocumentTitle(title) {
  useEffect(() => {
    document.title = title;

    return () => {
      console.log("clean up");
    };
  });
}
```

* Counters.jsx

```jsx
...
import useDocumentTitle from "./useDocumentTitle";
...
  useDocumentTitle(name + " has clicked " + count + " times!");
  ...
```

### 10 - Fetching Data with Hooks

* <https://jsonplaceholder.typicode.com/users>
* install axios
* src\hooks\Users.jsx

```jsx
import React, { useEffect, useState } from "react";
import axios from "axios";

function Users(props) {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    async function getUsers() {
      const result = await axios("https://jsonplaceholder.typicode.com/users");
      setUsers(result.data);
    }

    getUsers();
  }, []);

  return (
    <div>
      <ul>
        {users.map(user => (
          <li key={user.id}>{user.name}</li>
        ))}
      </ul>
    </div>
  );
}

export default Users;

```

### 11 - Context

* props drillig
  * to pass object(e.g. users) from top component to lower component
    * as project grows bugger, this may become complicated
* context
  * act like global storage

### 12 - Context in Class Component

* provider/consumer
* context/UserContext.js

```js
import React from "react";

const UserContext = React.createContext();
UserContext.displayName = "UserContext";

export default UserContext;
```

* App.js

```js
import React from "react";
import MoviePage from "./context/moviepage";
import UserContext from "./context/usercontext";
class App extends React.Component {
  state = { currentUser: { name: "ian" } };
  render() {
    return (
      <UserContext.Provider value={this.state.currentUser}>
        <div>
          <MoviePage />
        </div>
      </UserContext.Provider>
    );
  }
}

export default App;
```

* movielist.jsx

```jsx
import UserContext from "./usercontext";
class MovieList extends React.Component {
  static contextType = UserContext;

  componentDidMount() {
    console.log("context", this.context);
  }
  render() {
    return (
      <UserContext.Consumer>
        {(userctx) => <div>{userctx.name}</div>}
      </UserContext.Consumer>
    );
  }
}
```

### 13 - Context in Functional Component

* useContext(hook)
  * only available for functional component
* App.js

```js
...
<UserContext.Provider value={this.state.currentUser}>
...
</UserContext.Provider>
...
```

* movielist.jsx

```jsx
...
import MovieRow from "./movierow";
...
        {(userctx) => (
          <div>
            {userctx.name}
            <MovieRow />
          </div>
        )}
        ...
```

* movierow.jsx

```jsx
import React, { useContext } from "react";
import UserContext from "./usercontext";
function MovieRow(props) {
  const currentUser = useContext(UserContext);
  console.log(currentUser);
  return <div>{currentUser.name}</div>;
}

export default MovieRow;
```
