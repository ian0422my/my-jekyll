---
layout: single
#classes: wide
title:  "React - Component"
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

## Components

### preparation

* softwares
  * node
    * module
      * create-react-app (npm i -g create-react-app@1.5.2)
* ide
  * visual studio code
  * extensions
    * prettier - code formatter
      * configure
        * settings
          * editor
            * default formatter
              * select prettier - code formatter
            * format on save: true
            * format on save mode: file
    * simple react snippet
      * imrc + tab
        * import React, { Component } from 'react';
      * cc + tab
        * import class skeleton
      * sfc + tab
        * create stateless functional components
    * Auto Import - ES6, TS, JSX, TSX

### development

* npm init react-app my-app
* cd my-app
* npm start
* visit <http://localhost:3000>

#### Project structure

* /public - public files (favicon.ico)
  * index.html - main html to render
* src - folders for components

#### Hello World

* create src/index.js with content below

```javascript
import React from 'react';
import ReactDOM from 'react-dom';

const element = <h1>hello world</h1>;

ReactDOM.render(element, document.getElementById('root'));//which wil render "element" into index.html's root div
```

### install bootstarp

* npm i bootstrap@4.1.1
* import into index.js
  * edit index.js
  * import 'bootstrap/dist/css/bootstrap.css';

### create components

* create src/components/counter.jsx
* edit counter.jsx

```jsx
import React, { Component } from 'react'; 
class Counter extends React.Component {
    render() { 
        return <h1>hello world</h1>;
    }
}
 
export default Counter;
```

* import into index.jsx and render

```jsx
import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';
import 'bootstrap/dist/css/bootstrap.css';
import Counter from './components/counter'; // here

ReactDOM.render(
  <Counter/>,  // here
  document.getElementById('root')
);
...
```

* refresh page

### Embedding Expression

* edit counter.jsx

```jsx
render() { 
    return <div class="temp"><h1>hello world</h1><button>increment</button></div>;
    // return <React.Fragment><h1>hello world</h1><button>increment</button></React.Fragment> // if you don't want the extra div.temp
}
```

### Embedding Expression - with state (36:01)

* edit counter.jsx and add

```jsx
import React, { Component } from "react";
class Counter extends React.Component {
  // add state
  state = {
    count: 1,
  };

  render() {
    return (
      <div>
        <span>{this.formatCount()}</span>
        <button>increment</button>
      </div>
    );
  }

  formatCount() {
    //return this.state.count === 0 ? 'zero': this.state.count;
    //const cnt = this.state.count;
    //return cnt === 0 ? 'zero' : cnt;
    const { count } = this.state;
    //return count === 0 ? zero : count;
    return count === 0 ? <h1>zero</h1> : count;
  }
}

export default Counter;
```

### Setting Attributes (40:55)

```jsx
import React, { Component } from "react";
class Counter extends React.Component {
  // add state
  state = { count: 0 };

  styles = {fontSize: 12}; 

  render() {
    return (
      <div>
        <span id="1" style={this.styles} className="badge badge-primary m-2">{this.formatCount()}</span> // non-inline style
        <button style=\{\{fontSize: 12}} className="btn btn-seconday btn-sm">increment</button> // inline style
      </div>
    );
  }

  formatCount() {
    //return this.state.count === 0 ? 'zero': this.state.count;
    //const cnt = this.state.count;
    //return cnt === 0 ? 'zero' : cnt;
    const { count } = this.state;
    return count === 0 ? "zero" : count;
  }
}

export default Counter;
```

### Rendering Classes Dynamically (46:40)

* change zero to yellow when zero

```jsx
import React, { Component } from "react";
class Counter extends React.Component {
  // add state
  state = { count: 0 };

  styles = {fontSize: 12}; 

  render() {
    return (
      <div>
        <span id="1" style={this.styles} className={this.getBadgeClasses()}>{this.formatCount()}</span>
        <button style=\{\{fontSize: 12}} className="btn btn-seconday btn-sm">increment</button>
      </div>
    );
  }

    getBadgeClasses() {
        let classes = "badge m-2 badge-";
        classes += (this.state.count === 0) ? "warning" : "primary";
        return classes;
    }

    formatCount() {
        //return this.state.count === 0 ? 'zero': this.state.count;
        //const cnt = this.state.count;
        //return cnt === 0 ? 'zero' : cnt;
        const { count } = this.state;
        return count === 0 ? "zero" : count;
    }
}

export default Counter;
```

### Rendering Lists - Using Map to Loop (51:02)

* render list of items

```jsx
import React, { Component } from "react";
class Counter extends React.Component {
  state = { 
    count: 0,
    tags: ['tag1','tag2','tag3'] // here
  };

  styles = {fontSize: 12}; 

  render() {
    return (
      <div>
        <span id="1" style={this.styles} className={this.getBadgeClasses()}>{this.formatCount()}</span> // display count here
        <button style=\{\{fontSize: 12}} className="btn btn-seconday btn-sm">increment</button>
        <ul>
            {this.state.tags.map(tag => <li key={tag}>{tag}</li>)} // here
        </ul>
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
}

export default Counter;
```

### Conditional Rendering (55:00)

```jsx
import React, { Component } from "react";
class Counter extends React.Component {
	state = { 
		count: 0,
		tags: ['tag1','tag2','tag3']
	};

	styles = {fontSize: 12}; 

	render() {
		return (
		<div>
			{this.state.tags.length===0?"Please create new tag":"Your selection"}
			{this.renderTags()}
		</div>
		);
	}

	renderTags() {
		if ( this.state.tags.length===0 ) return "no tags defined";
		
		return <ul>{this.state.tags.map(tag => <li key={tag}>{tag}</li>)}</ul>;
	}
}
```

export default Counter;

### Handling Events (1:00:05)

```jsx
import React, { Component } from "react";
class Counter extends React.Component {
  state = { 
    count: 0,
    tags: ['tag1','tag2','tag3'] 
  };

  styles = {fontSize: 12}; 

  render() {
    return (
      <div>
        <span id="1" style={this.styles} className={this.getBadgeClasses()}>{this.formatCount()}</span> // display count here
        <button onClick={this.handleIncrement} // here
        style=\{\{fontSize: 12}} className="btn btn-seconday btn-sm">increment</button>
        <ul>
            {this.state.tags.map(tag => <li key={tag}>{tag}</li>)} // here
        </ul>
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

	handleIncrement() {// here
		console.log(11);
	}
}

export default Counter;
```

### Binding Event Handler (1:00:04)

```jsx
import React, { Component } from "react";
class Counter extends React.Component {
	state = { 
    count: 0,
    tags: ['tag1','tag2','tag3'] 
  };

  styles = {fontSize: 12}; 

  render() {
    return (
      <div>
        <span style={this.styles} className={this.getBadgeClasses()}>{this.formatCount()}</span> // display count here
        <button onClick={this.handleIncrement} style=\{\{fontSize: 12}} className="btn btn-seconday btn-sm">increment</button>
        <ul>
            {this.state.tags.map(tag => <li key={tag}>{tag}</li>)} 
        </ul>
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

	handleIncrement = () => { // here
		this.state.count = this.state.count + 1;

		console.log(this);
	}
}

export default Counter;
```

### Updating The State (1:00:08)

* update the state and refresh the view (using Component.setState(object))

```jsx
import React, { Component } from "react";
class Counter extends React.Component {
	state = { 
    count: 0,
    tags: ['tag1','tag2','tag3'] 
  };

  styles = {fontSize: 12}; 

  render() {
    return (
      <div>
        <span style={this.styles} className={this.getBadgeClasses()}>{this.formatCount()}</span> // display count here
        <button onClick={this.handleIncrement} style=\{\{fontSize: 12}} className="btn btn-seconday btn-sm">increment</button>
        <ul>
            {this.state.tags.map(tag => <li key={tag}>{tag}</li>)} 
        </ul>
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

	handleIncrement = () => {
		this.state.count++;
		this.setState({count: this.state.count++}); // here
	}
}

export default Counter;
```

### What happen when state changes (1:00:11)

* state changes > virtual changes > actual dom changes
  * only affected dom are updated on this page (other dom is not affected)

### Passing Events Arguments for Method Referencing (1:00:13)

* change from

```jsx
import React, { Component } from "react";
class Counter extends React.Component {
	state = { 
    count: 0,
    tags: ['tag1','tag2','tag3'] 
  };

  styles = {fontSize: 12}; 

  render() {
    return (
      <div>
        <span style={this.styles} className={this.getBadgeClasses()}>{this.formatCount()}</span> // display count here
        <button onClick={() => this.handleIncrement("name1")} style=\{\{fontSize: 12}} className="btn btn-seconday btn-sm">increment</button> // here
        <ul>
            {this.state.tags.map(tag => <li key={tag}>{tag}</li>)} 
        </ul>
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

	handleIncrement = (productName) => { // here
		console.log("incrementing for production " + productName);
		this.state.count++;
		this.setState({count: this.state.count++});
	}
}

export default Counter;
```