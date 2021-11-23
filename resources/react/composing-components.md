---
layout: single
# classes: wide
title:  "React - Composing Components"
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

## Composing Components

### Composing Components (1:17:34)

* create src/counters.jsx
* edit index.js

```js
import Counters from './components/counters'//here
...
ReactDOM.render(
  <Counters/>,//here
  document.getElementById('root')
);
```

* edit counters.jsx

```jsx
import React, { Component } from 'react';
import Counter from './counter'

class Counters extends React.Component {
  state = {
    counters: [
      {id:1, value:3},//here
      {id:2, value:0},//here
      {id:3, value:0},//here
      {id:4, value:0}//here
    ]
  }

  render() { 
    return (<div>
      {this.state.counters.map(counter=>
        <Counter 
          id={counter.id}
          value={counter.value}
        />
      )}
    </div>);
  }
}
 
export default Counters;
```

### Passing Children (1:24:35)

* counters.jsx

```jsx
import React, { Component } from 'react';
import Counter from './counter'

class Counters extends React.Component {
  state = {
    counters: [
      {id:1, value:3},
      {id:2, value:0},
      {id:3, value:0},
      {id:4, value:0}
    ]
  }

  render() { 
    return (<div>
      {this.state.counters.map(counter=>
        <Counter 
          key={counter.id} 
          id={counter.id}
          value={counter.value}
          titleName={counter.id}
        /> // here
      )}
    </div>);
  }
}
 
export default Counters;
```

* counter.jsx

```jsx
import React, { Component } from "react";
class Counter extends React.Component {
	state = { 
    count: this.props.value // here
  };

  styles = {fontSize: 12}; 

  render() {
    return (
      <div>
        {this.props.titleName} // here
        <span style={this.styles} className={this.getBadgeClasses()}>{this.formatCount()}</span>
        <button onClick={() => this.handleIncrement("name1")} style=\{\{fontSize: 12}} className="btn btn-seconday btn-sm">increment</button>
      </div>
    );
  }

  getBadgeClasses() {
		let classes = "badge m-2 badge-";
		classes += (this.state.count === 0) ? "warning" : "primary";
		return classes;
  }

  formatCount() {
		const { count } = this.state;
		return count === 0 ? "zero" : count;
  }

	handleIncrement = (productName) => {
		console.log("incrementing for production " + productName);
		this.state.count++;
		this.setState({count: this.state.count++});
	}
}

export default Counter;
```

### Debugging React Apps (1:27:47)

* chrome
  * install react developer tools
  * inspect element
  * select react
* inspect element
  * you can see all the components

### Prop vs State(1:31:59)

| state                               | props                                                  |
| :---------------------------------- | :----------------------------------------------------- |
| read and write                      | read only; can only set during component instantiation |
| private;visible from component only | public; can see from outside                           |

### Decrement button

* edit counter.jsx
* add line below, go to end of the line and tab (auto-complete)

```txt
button.btn.btn-danger.btn-sm.m-2
```

* will become

```jsx
<button className="btn btn-danger btn-sm m-2"></button>
```

* edit counters.jsx (to pass contorl to counter)

```jsx
import React, { Component } from 'react';
import Counter from './counter'

class Counters extends React.Component {
  state = {
    counters: [
      {id:1, value:3},
      {id:2, value:0},
      {id:3, value:0},
      {id:4, value:0}
    ]
  }

  render() { 
    return (<div>
      {this.state.counters.map(counter=>
        <Counter 
          key={counter.id} 
          id={counter.id}
          value={counter.value}
          titleName={counter.id}
          handleDelete={this.handleDelete} // here
        />
      )}
    </div>);
  }

  handleDelete() { // here
    console.log("handleDelete ||| delete");
  }
}
 
export default Counters;
```

* edit counter.jsx

```jsx
import React, { Component } from "react";
class Counter extends React.Component {
	state = { 
    count: this.props.value
  };

  styles = {fontSize: 12}; 

  render() {
    return (
      <div>
				Counter #{this.props.titleName}
        <span style={this.styles} className={this.getBadgeClasses()}>{this.formatCount()}</span>
        <button onClick={() => this.handleIncrement("name1")} style=\{\{fontSize: 12}} className="btn btn-seconday btn-sm">increment</button>
				 <button onClick={this.props.handleDelete} className="btn btn-danger btn-sm m-2">delete</button> // here 
      </div>
    );
  }

  ...
}

export default Counter;
```

### Updating the delete state (1:39:19)

* counters.jsx

```jsx
import React, { Component } from 'react';
import Counter from './counter'

class Counters extends React.Component {
  ...

  handleDelete = (counterId) => { // here
    const counters = this.state.counters.filter(c=>c.id != counterId);

    this.setState({counters: counters});
  }
}
 
export default Counters;
```

* counters.jsx

```jsx
import React, { Component } from "react";
class Counter extends React.Component {
  ...
  render() {
    return (
      <div>
        ...
				<button onClick={() => this.props.handleDelete(this.props.id)} className="btn btn-danger btn-sm m-2">delete</button> // here
      </div>
    );
  }
  ...
}

export default Counter;
```

### Passing whote object (1:41:37)

* counters.jsx

```jsx
import React, { Component } from 'react';
import Counter from './counter'

class Counters extends React.Component {
  ...
  render() { 
    return (<div>
      {this.state.counters.map(counter=>
        <Counter
          key={counter.id} 
          counter={counter} // here
          handleDelete={this.handleDelete}
        />
      )}
    </div>);
  }
  ...
}
 
export default Counters;
```

* counter.jsx

```jsx
import React, { Component } from "react";
class Counter extends React.Component {
	state = { 
    count: this.props.counter.value // here
  };
  ...
  render() {
    return (
      <div>
				Counter #{this.props.counter.id}
        <span style={this.styles} className={this.getBadgeClasses()}>{this.formatCount()}</span>
        <button onClick={() => this.handleIncrement("name1")} style=\{\{fontSize: 12}} className="btn btn-seconday btn-sm">increment</button>
				 <button onClick={() => this.props.handleDelete(this.props.counter.id)} className="btn btn-danger btn-sm m-2">delete</button>
      </div>
    );
  }
  ...
}

export default Counter;
```

### single source of truth (1:44:00)

* deleting counters.state.counters will not refresh counter.state.count (since counter.state.count is initialized only once and component is re-render again)

### removing the local state - in counter (1:47:56)

* counters.jsx

```jsx
class Counters extends React.Component {
  ...
  render() { 
    return (<div>
      {this.state.counters.map(counter=>
        <Counter
          key={counter.id}
          counter={counter}
          handleDelete={this.handleDelete} // here
          handleIncrement={this.handleIncrement} // here
        />
      )}
    </div>);
  }
// here
  handleDelete = (counter) => {
    const counters = this.state.counters.filter(c=>c.id !== counter.id);

    this.setState({counters});
  }
// here
  handleIncrement = (counter) => {
    const counters = [...this.state.counters];
    const index = counters.indexOf(counter);    
    counters[index] = {...counter};
    counters[index].value++;
    this.setState({counters});
  }
}
 
export default Counters;
```

* counter.jsx

```jsx
class Counter extends React.Component {
  ...
  render() {
    return (
      <div>
        ...
        <button onClick={() => this.props.handleIncrement(this.props.counter)} style=\{\{fontSize: 12}} className="btn btn-seconday btn-sm">increment</button> // here
				 <button onClick={() => this.props.handleDelete(this.props.counter)} className="btn btn-danger btn-sm m-2">delete</button> // here
      </div>
    );
  }
  ...
}

export default Counter;
```

### Multiple Components in Sync (1:54:47)

* we are going to change the component tree
  * from
    * App
      * NavBar
      * Counters - State
        * Counter
    * App - State
      * NavBar
      * Counters
        * Counter

* index.js - point to App

```js
ReactDOM.render(
  <App/>,
  document.getElementById('root')
);
```

* App.js - point to NavBar and Counters

```jsx
import NavBar from './components/navbar';
import Counters from './components/counters';
class App extends React.Component {
```

* goto <https://getbootstrap.com/docs/5.1/components/navbar/> and copy the html and paste below
* navbar.jsx - new file

```jsx
import React, { Component } from 'react';
class NavBar extends React.Component {
  render() { 
    return <nav className="navbar navbar-light bg-light">
    <div className="container-fluid">
      <a className="navbar-brand" href="#">Navbar</a>
    </div>
  </nav>;
  }
}
 
export default NavBar;
```


### Lifting State Up (2:00:42)

* move state and handle method from Counters to App
  * pass state/control from App to Counters
    * E.g.
      * counters={this.state.counters}
      * handleReset={this.handleReset}
  * pass state from App to NavBar
    * E.g.
      * <NavBar totalCounters={this.props.totalCounters}/>
  * change reference to props in Counters.jsx
    * E.g.
      * handleDelete={this.props.handleDelete}
  * show totalCounters state in NavBar
    * E.g.
      * {this.props.totalCounters}
* show state in navbar
* App.js

```js
import './App.css';
import NavBar from './components/navbar';
import React, { Component } from 'react';
import Counters from './components/counters';

class App extends React.Component {
  state = {
    counters: [
      {id:1, value:3},
      {id:2, value:2},
      {id:3, value:1},
      {id:4, value:0}
    ]
  }

  handleReset = () => {
    console.log("resetting");
    const counters = [...this.state.counters];
    counters.filter(c=>console.log("check : " + c.id + " : " + c.value));
    counters.filter(c=>c.value=0);
    this.setState({counters});
  }

  handleDelete = (counter) => {
    const counters = this.state.counters.filter(c=>c.id !== counter.id);

    this.setState({counters});
  }

  handleIncrement = (counter) => {
    const counters = [...this.state.counters];
    const index = counters.indexOf(counter);    
    counters[index] = {...counter};
    counters[index].value++;
    this.setState({counters});
  }

  render() { 
    return (
      <React.Fragment>
        <NavBar totalCounters={this.state.counters.filter(c=>c.value>0).length}/>
        <Counters
          counters={this.state.counters}
          handleReset={this.handleReset} 
          handleIncrement={this.handleIncrement}
          handleDelete={this.handleDelete}
        />
      </React.Fragment>
    );
  }
}
 
export default App;
```

* Counters.jsx

```jsx
import React, { Component } from 'react';
import Counter from './counter'

class Counters extends React.Component {
  render() { 
    return (<div>
      <div><button className="btn btn-primary btn-sm m-2" onClick={() => this.props.handleReset()}>reset</button></div>
      <div>{this.props.counters.map(counter=>
        <Counter
          key={counter.id}
          counter={counter}
          handleDelete={this.props.handleDelete}
          handleIncrement={this.props.handleIncrement}
        />
      )}</div>
    </div>);
  }
}
 
export default Counters;
```

### Stateless Functional Components - sfc(2:06:20)

* since navbar is view only with no helper function, we can decide to render class or sfc
* edit navbar.jsx
* sfc + tab

```jsx
const NavBar = () => {
  return <nav className="navbar navbar-light bg-light">
  <div className="container-fluid">
    <a className="navbar-brand" href="#">Navbar 
      <span className="badge badge-pill badge-secondary">{this.props.totalCounters}</span></a>
  </div>
</nav>;
}
 
export default NavBar;
```

### Destructuring Arguments (2:08:53)

* instead of calling this.props. multiple times in counters.jsx, we can destructure the argemnets
  * from
    * <Counter handleIncrement={this.props.handleIncrement} handleReset={this.handleReset}>
  * to
    * const {handleIncrement, handleReset} = this.props;
    * <Counter handleIncrement={handleIncrement} handleReset={handleReset}>

### Lifecycle Hook (2:10:54)

* can only use on component (cannot use on SFC)
* 3 phase with hook (method)
  * mount - create compoment
    * hook
      * constructor
      * render
      * componentDidMount - DOM rendered
  * update - update componnet
    * render
    * componentDidUpdate
  * unmount - remove component
    * componentWillUnmount

### Mounting Phase (2:12:33)

* when render is called, the child render is called too
* constructor is called only once
* componentDidMount should be the place when api is invoked to get data and render the UI

### Updating Phase (2:18:12)

* componentDidUpdate can use to compare values and decide to fetch from api

```js
componentDidUpdate(prevProps, prevState) {
  console.log(prevProps);
}
```

### Unmounting Phase (2:18:12)

* call before component is removed
* componentWillUnmount can be called to do cleanup

### 19/20 - Exercise

* add decrement button
  * disable decrement button when 0
* use bootstrap grid
  * col-1
    * first column
  * col 
    * the rest of the column
* App.js

```js
  handleDecrement = (counter) => {
    const counters = [...this.state.counters];
    const index = counters.indexOf(counter);
    counters[index] = { ...counter };
    counters[index].value--;
    this.setState({ counters });
  };
  ...
  handleDelete={this.handleDelete}
```

* counters.jsx

```js
  render() {
    const {
      handleReset,
      handleDelete,
      handleIncrement,
      handleDecrement, // here
      counters,
    } = this.props;
...
          {counters.map((counter) => (
            <Counter
              key={counter.id}
              counter={counter}
              handleDelete={handleDelete}
              handleIncrement={handleIncrement}
              handleDecrement={handleDecrement} // here
            />
```

* counters.jsx

```js
<button
  onClick={() => this.props.handleDecrement(this.props.counter)}
  style=\{\{ fontSize: 12 }}
  className="btn btn-seconday btn-sm m-2"
  disabled={this.props.counter.value === 0 ? "disabled" : ""}
>
  -
</button>
```

### 21/22 - Exercise

* add like (e.g. like button)
  * use [font awesome](https://fontawesome.com/v5.15/icons/heart?style=solid)
  * copy html
* add src/common folder
* create like.jsx

```html
import React, { Component } from "react";

class Like extends React.Component {
  handleLikeClass() {
    if (this.props.liked) return "fa fa-heart";
    else return "fa fa-heart-o";
  }
  render() {
    return (
      <span onClick={() => this.props.handleLiked(this.props.movie)}>
        <i style=\{\{ cursor: "pointer" }} className={this.handleLikeClass()}></i>
      </span>
    );
  }
}

export default Like;
```

* movie.jsx
  * import like, pass control and movie object to like.jsx

```js
  <Like
    liked={liked}
    handleLiked={this.props.handleLiked}
    movie={this.props.movie}
  />
```

* movies.jsx
  * implement the method and pass the control to movie.jsx

```js
  handleLiked = (movie) => {
    let movies = [...this.state.movies];
    let index = this.state.movies.indexOf(movie);
    movies[index].liked = !movies[index].liked;
    this.setState({ movies });
  };
  ...
  <Movie
    key={m._id}
    movie={m}
    handleDelete={this.handleDelete}
    handleLiked={this.handleLiked}
  />
```