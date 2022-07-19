---
layout: single
classes: wide
title:  "React"
date:   2021-11-15 10:00:50 +0800
categories: react
allow_different_nesting: true
sidebar:
  nav: "react"
---

## Cheatsheet

* visual studio code
  * srs = simple react snippet (visual studio code extension)
  * prettier
  * sonarlint
  * project manager

| type         | code                                                                                 | description                                                                           |
| :----------- | :----------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------ |
| vscode,srs   | imrc > tab                                                                           | import react component                                                                |
| vscode,srs   | cc > tab                                                                             | create class component skeleton                                                       |
| vscode,srs   | ccc > tab                                                                            | create class component with constructor                                               |
| vscode,srs   | sfc > tab                                                                            | create stateless functional component skeleton                                        |
| vscode,srs   | table.table>thead>tr>td*4>h1+span.m-2[style="cursor:pointer"] + tab                  | generate table with thead,tr,4 Td, h1 and span(same lvl) with style; zen              |
| vscode,srs   | log+tab -> console.log()                                                             |                                                                                       |
| vscode,srs   | error+tab -> console.error()                                                         |                                                                                       |
| vscode,srs   | warn+tab -> console.warn()                                                           |                                                                                       |
| vscode,srs   | loc+tab -> localstorage                                                              |                                                                                       |
| vscode,srs   | trycatch+tab -> try {} catch (ex) {}                                                 |                                                                                       |
| vscode,srs   | cdm+tab -> componentDidMount(){}                                                     |                                                                                       |
| vscode,srs   | cdu+tab -> componentDidUpdate(){}                                                    |                                                                                       |
| vscode,srs   | cdun+tab -> componentWillUnmount(){}                                                 |                                                                                       |
| css          | \<span className=\{\{m-2 col-2\}\}\/>\<span className=\{\{col\}\}>                   | 1st column occupy 2 column(grid system has 12 columns); 2nd span the rest of columns  |
| js           | const one=1;console.log(`one is ${one}`);                                            | refer to literals?                                                                    |
| js           | let errors = { errors: errors \|\| {} }                                              | "\|\|" return left operand if left operand is truthy                                  |
| js           | let errors = { errors: errors && {} }                                                | "\|\|" return right operand if left operand is truthy                                 |
| js           | typeof var1 === 'string' ? "i am a string":"unknown"                                 | check object type                                                                     |
| js           | const counters = [...this.state.counters, {}]                                        | spread operators; clone object array with additional object                           |
| js           | totalCounters={this.state.counters.filter(c=>c.value>0).length}/>                    | copy with filtering condition and results in array object                             |
| js           | let person ={persons.filter(p=>p.name==="ian");                                      | copy with filtering condition and results in array object                             |
| js           | this.state.counters.map((counter)=>console.log(counter.id));                         | iterate                                                                               |
| js           | async getMovies() { const {data:m} = await http.getMovies(); return m;}              | fetch data and return only when request is promised; code hang if no response         |
| js           | getMovies = async() => { const {data:m} = await http.getMovies(); return m;}         | fetch data and return only when request is promised                                   |
| js           | try{...}catch(ex){if(ex.response.status===404)} {...}                                | check exception http status                                                           |
| js           | \<Route render={(p)=>if(login)return \<Route to="/login"/> else return \<Home/>}/>   | if else within expression                                                             |
| js           | \<a href="javascript:;">                                                             | prevent default behavior                                                              |
| js,fs        | cconst fs = require('fs'); fs.copyFile('src','dest',(err) =>{if(err) throw err;});   | copy file                                                                             |
| js,err       | throw new Error(message) - try{}catch(err){console.log(err.name)}                    | catch exception for normal method                                                     |
| js,err       | method1(){} - await method1().catch(err=>console.log(err.name+err.message))          | catch exception for async method                                                      |
| js,arr       | let movies={id:1,name:"2"}; Object.keys(movies).length                               | length of all keys of an object                                                       |
| js,arr       | const index = movies.indexOf(movie); const movie = movies[index];                    | getting the index of object in an array and get the object based on index             |
| js,arr       | const a1 = [1,2,3]; const a2 = [4,5,6];const combined = [...a1, 'a', ...a2, 'b'];    | combine array and new item                                                            |
| js,arr       | item={id:"1", name:"ian"}; key="id";item[key] == 1;//true                            | access value of items dynamically by name(i.e. no hardcode like item.id)              |
| js,arr       | let name="id";let property = { [name]: value };                                      | create object with dynamic key                                                        |
| js,arr       | let movies=[];movie={};movies.push(movie);                                           | add object in array                                                                   |
| js,arr       | let movies=[];let newMovies = movies.filter(i=>i._id!==idToBeRemoved);               | remove object from array                                                              |
| js,arr       | let movies=[];movies.pop()                                                           | remove last object from array                                                         |
| js,arr       | let movies={id:1}; delete movies._id                                                 | remove key from array                                                                 |
| js,arr       | let csv=array.join(",");                                                             | convert string array to csv                                                           |
| js,arr       | let array=csv.split(",");                                                            | convert string csv to array                                                           |
| js,browser   | localStorage.setItem('token',jwt)                                                    | store value in browser's local storage                                                |
| js,browser   | localStorage.getItem("token")                                                        |                                                                                       |
| js,browser   | localStorage.deleteItem("token)                                                      |                                                                                       |
| lodash       | let pages = lodash.range(min, max);                                                  | create array with min, max size                                                       |
| lodash       | _(items).slice(startIndex).take(pageSize).value()                                    | cut a chuck sizes(pageSize) of items from start(index)                                |
| lodash       | const sortedMovies = _.orderBy(array,["field1",...],["asc"];                         | sorting array                                                                         |
| lodash       | _.get(object, path)                                                                  | get object member by path                                                             |
| joi          | schema = {uname: Joi.required()};let errors = Joi.validate({uname:""}, schema)       | define Joi schema,validate object and return validation message with friendly name    |
| joi          | schema={id: Joi.allow('')};                                                          | allow empty                                                                           |
| joi          | Joi.string().valid("chinese", "italy", "french", "thailand")                         | valid within list only                                                                |
| joi          | Joi.string()..regex(/[a-zA-Z0-9]{8,30}/)                                             | regex validation (must contain small,capital, min 8,max 30)                           |
| axios        | const { data: posts } = await axios.get(getEndpoint);                                | get from rest api                                                                     |
| axios        | const { data: post } = await http.post(postEndpoint, { title: "a", body: "b" });     | add; post to rest api with body                                                       |
| axios        | const data = await http.patch(putEndpoint + "/" + post.id, {title: post.title});     | update; update a single property of an object(post update the whole object)           |
| axios        | const data = await http.put(putEndpoint + "/" + post.id, post);                      | update; update an object                                                              |
| toast        | toast.error("error!!!");                                                             | display error using toast notification                                                |
| query-string | npm i query-string@6.1.0; queryString.parse(location.search);                        | parse queryString as object                                                           |
| jwt-decode   | const user = jwtDecode(jwt);                                                         |                                                                                       |
| react        | svc1.js>export function m1(){};import * as svc1 from './svc1.js';svc1.m1();          | export a service, and import all service                                              |
| react        | auth.js>function m1(){};export default {m1} - import auth from 'auth'; auth.m1()     | export module; import module and invoke function                                      |
| react        | this.setState({counters});                                                           | update state and refresh the view                                                     |
| react        | {error && \<div className="alert alert-danger">{error}</div>}                        | show when "error" is not null                                                         |
| react        | React.Fragment                                                                       | create component without div                                                          |
| react        | const {handleReset, counters} = this.props; handleReset();                           | destructing argument                                                                  |
| react        | const {handleReset: customVarName} = this.props; customVarName();                    | destructing argument with custom variable name                                        |
| react        | onClick={() => handleReset(this.state.counters)}                                     | pass reference to a method with arg                                                   |
| react        | state={m1: name => \<h1>welcome {name}</h1>}; \<Profile m1={this.state.m1}/>         | pass reference to a method with arg as object member                                  |
| react        | onClick={handleReset}                                                                | pass reference to a method without arg                                                |
| react        | parent - \<Counter total=1>; child - this.props.total                                | passing value from parent to child                                                    |
| react        | parent - \<Counter fn1={fn1}>; child - this.props.fn1()                              | passing method(no arg) reference from parent to child                                 |
| react        | parent - \<Counter fn1={fn1}>; child - () => this.props.fn1(param1,param2)           | passing method(with arg) reference from parent to child                               |
| react        | this.setState({movie}); // rather than {movie:movie}.                                | ecma6; use when key=value;shorter and cleaner code                                    |
| react        | Pagination.propTypes = {itemCount: PropTypes.number.isRequired}                      | enforce type - number and required - for a class member                               |
| react        | MyComponent.defaultProps = { customProp: "default value"}                            | set default value for props member                                                    |
| react        | \<Component key={"name-"+this.state.data.key}/>                                      | component will be re-rendered(componentDidMount) when key value changes               |
| react,rrd    | \<Link to="/path"/>                                                                  | ui; change url without reloading bundle.js                                            |
| react,rrd    | \<NavLink to="/path">                                                                | ui; change url; highlight automatically once clicked                                  |
| react,rrd    | \<Switch/>\<Route/>                                                                  | spa; render component based on path. If match, stop processing the rest               |
| react,rrd    | \<Route path="/path" component="Products"/>                                          | spa; render component based on path with existing props                               |
| react,rrd    | \<Route render={(props)=>\<Product name={name} {...props}/>}/>; this.props.name;     | spa; render component based on path with additonal(name) and existing props           |
| react,rrd    | \<Route path="/posts/:year?" component={Posts} />; year=this.props.match.params.year | spa; path with optional parameters                                                    |
| react,rrd    | render() \{return \<Redirect to="/home"/>}                                           | spa; redirect                                                                         |
| react,rrd    | \<Redirect from="/" to="/"/>                                                         | spa; redirect                                                                         |
| react,rrd    | \<Redirect from="/" to={{pathname:"/login",state:{here: this.props.location}}}/>     | spa;redirect to path(with existing props;access using this.props.location.state.here  |
| react,rrd    | http://url/?year - let {year} = queryString.parse(this.props.location.search);       | read query param                                                                      |
| react,rrd    | http://url/:year/ - let year = this.props.match.params.year                          | read url param                                                                        |
| react,rrd    | this.props.history.replace(url)                                                      | change browser url without history                                                    |
| react,rrd    | this.props.history.push(url)                                                         | change browser url with history                                                       |
| react        | \<form onSubmit=\{this.handleSubmit\}>\<button name="Login"/>                        | submit form                                                                           |
| react        | \<input onChange=\{this.onChange\}/>;onChange(e) {}                                  | call function when input changes                                                      |
| react        | \<select onChange=\{this.onChange}>/>;onChange(e) {}                                 | call function when select changes                                                     |
| react        | .env.production.json>REACT_APP_NAME=vidly>console.log(process.env.REACT_APP_NAME)    | creat environemnt specific json and read the value (must start with REACT_APP_*)      |
| react,serve  | npm run build; npm i -g serve; serve -s build                                        | build prod("build") folder;install lightweight webserver;run app in "build" folder    |
| react,heroku | heroku login                                                                         | login to heroku(popup to UI)                                                          |
| react,heroku | heroku create --buildpack https://github.com/mars/create-react-app-buildpack.git     | create heroku app for created using create-react-app                                  |
| react,heroku | cd vidly;heroku create; git push heroku master; heroku open                          | create heroku app; push code to heroku git repo and build; open heroku app in browser |
| react,heroku | heroku tail [--tail]                                                                 | open/tail heroku logs                                                                 |
| react,heroku | heroku config:get NODE_ENV -a blooming-beyond-16719                                  | check config                                                                          |
| react,heroku | heroku config:set envkey=envval                                                      | create environment variables (aslo can do so via app > settings > reveal config vars) |
| react,heroku | heroku restart                                                                       | restart heroku app                                                                    |
| react,heroku | heroku maintenance:on/off                                                            | kind of bring down the app                                                            |
| react,adv    | npx create-react-app react-advanced                                                  | create react app using npx                                                            |
| react,hoc    | return class WithTooltip extends React.Component {render(){}}                        | HOC; create class component as a return object                                        |
| react,ffc    | var [count, setCount] = useState(0);{setCount(count++)}                              | useState (setState for CC)                                                            |
| react,ffc    | useEffect(function, [dependency arrays])                                             | useEffect (componentDidMount,componentDidUpdate,componentWillUnmount for CC)          |
| react,ffc    | const ctx = React.createContext();export default ctx;                                | create and export context                                                             |
| react,ffc    | import context from "./context";const ctx = useContext(context);                     | import and consume context                                                            |
| react,ffc    | const currentUser = useContext(UserContext);                                         | global storage; refer [#snippet]                                                      |

## Lifecycle

| component | function | mount | setState | can see props passed by parent |
| :-------- | :------- | :---- | :------- | :----------------------------- |
| parent    | render   | yes   |          | -                              |
| child     | render   | yes   |          | yes                            |
| child     | cdm      | yes   |          | yes                            |
| parent    | cdm      | yes   |          | -                              |
| parent    | render   | yes   | yes      | -                              |
| child     | render   | yes   | yes      | yes                            |
| child     | cdu      | yes   | yes      | yes                            |
| parent    | cdu      | yes   | yes      | -                              |

## Snippet

### New Project

* follow steps below, OR unzip hello-world.7z

#### create project

```cmd
npx create-react-app hello-world
```

#### import essential libraries

```cmd
cd hello-world
npm i react-router-dom@4.3.1
npm i bootstrap@4.1.1
npm i font-awesome@4.7.0
npm i lodash@4.17.10
npm i query-string@6.1.0
npm i joi-browser@13.4
npm i axios@0.18
npm i react-toastify@4.1
npm i sentry
npm i jwt-decode@2.2.0
```

#### create essential skeleton

##### services

* create src/services folder
* copy services below from what-to-cook/src/services/ to src/services/
  * authService.js
  * logSerivce.js
  * httpService.js

##### common component

* create src/components folder
* copy common folder from what-to-cook/src/components/ to src/components/

##### src/index.js

```js
import React from "react";
import ReactDOM from "react-dom";
import { BrowserRouter } from "react-router-dom";
import reportWebVitals from "./reportWebVitals";
import App from "./App";
import "./index.css";
import "bootstrap/dist/css/bootstrap.css";
import "font-awesome/css/font-awesome.css";

ReactDOM.render(
  <BrowserRouter>
    <App />
  </BrowserRouter>,
  document.getElementById("root")
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
```

##### src/App.js

```js
import React, { Component } from "react";
import { Switch, Route, Redirect } from "react-router-dom";
import { ToastContainer } from "react-toastify";
import NotFound from "./components/common/notfound";
import NavBar from "./components/common/navbar";
import Home from "./components/home";
import AboutUs from "./components/aboutus";
import "./App.css";
import "react-toastify/dist/ReactToastify.css";

export default class App extends Component {
  state = {
    menus: [
      {
        link: "/home",
        label: "Home",
        className: "fa fa-home",
        secure: true,
      },
      {
        link: "/aboutus",
        label: "About Us",
        className: "fa fa-about",
        secure: true,
      },
    ],
  };

  render() {
    return (
      <React.Fragment>
        <ToastContainer />
        <NavBar menus={this.state.menus} />
        <Switch>
          <Route path="/home" component={Home} />
          <Route path="/aboutus" component={AboutUs} />
          <Route path="/notfound" component={NotFound} />
          <Redirect from="/" exact to="/home" />
          <Redirect to="/notfound" />
        </Switch>
      </React.Fragment>
    );
  }
}
```

##### src/App.css

```css
.App {
  text-align: center;
}

.App-logo {
  height: 40vmin;
  pointer-events: none;
}

@media (prefers-reduced-motion: no-preference) {
  .App-logo {
    animation: App-logo-spin infinite 20s linear;
  }
}

.App-header {
  background-color: #282c34;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  font-size: calc(10px + 2vmin);
  color: white;
}

.App-link {
  color: #61dafb;
}

@keyframes App-logo-spin {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

a {
  text-decoration: none;
}

/* Add a black background color to the top navigation */
.topnav {
  background-color: #263f73;
  overflow: hidden;
}

/* Style the links inside the navigation bar */
.topnav a {
  float: left;
  display: block;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
}

.topnav span {
  float: left;
  display: block;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
  background: none;
  border: none;
  cursor: pointer;
}

/* Change the color of links on hover */
.topnav a:hover {
  background-color: #05a6a6;
  color: white;
}

.topnav span:hover {
  background-color: #05a6a6;
  color: white;
}

/* Add an active class to highlight the current page */
.topnav a.active {
  background-color: #05a6a6;
  color: white;
}

.topnav span.active {
  background-color: #05a6a6;
  color: white;
}

/* Hide the link that should open and close the topnav on small screens */
.topnav .icon {
  display: none;
}

/* When the screen is less than 700 pixels wide, hide all links, except for the first one ("Home"). Show the link that contains should open and close the topnav (.icon) */
@media screen and (max-width: 700px) {
  .topnav a:not(:first-child) {
    display: none;
  }
  .topnav a.icon {
    float: right;
    display: block;
  }

  .topnav span:not(:first-child) {
    display: none;
  }
  .topnav span.icon {
    float: right;
    display: block;
  }

  .topnav.responsive {
    position: relative;
  }
  .topnav.responsive a.icon {
    position: absolute;
    right: 0;
    top: 0;
  }
  .topnav.responsive a {
    float: none;
    display: block;
    text-align: left;
  }

  .topnav.responsive span.icon {
    position: absolute;
    right: 0;
    top: 0;
  }
  .topnav.responsive span {
    float: none;
    display: block;
    text-align: left;
  }

  .sidebar {
    width: 100%;
    height: auto;
    position: relative;
  }
  .sidebar a {
    float: left;
  }
  div.content {
    margin-left: 0;
  }
  th.clickable span span {
    display: none;
  }
}

/* The side navigation menu */
.sidebar {
  margin: 0;
  padding: 0;
  width: 200px;
  background-color: #f1f1f1;
  position: fixed;
  height: 100%;
  overflow: auto;
}

/* Sidebar links */
.sidebar a {
  display: block;
  color: black;
  padding: 16px;
  text-decoration: none;
}

/* Active/current link */
.sidebar a.active {
  background-color: #05a6a6;
  color: white;
}

/* Links on mouse-over */
.sidebar a:hover:not(.active) {
  background-color: #555;
  color: white;
}

/* Page content. The value of the margin-left property should match the value of the sidebar's width property */
div.content {
  margin-left: 200px;
  padding: 1px 16px;
  height: 1000px;
}

td a {
  color: #000 !important;
  text-decoration: none !important;
}

.hidden {
  display: none !important;
}

/* The Modal (background) */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0, 0, 0); /* Fallback color */
  background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content {
  background-color: #fefefe;
  margin: 15% auto; /* 15% from the top and centered */
  padding: 20px;
  border: 1px solid #888;
  width: 90% !important; /* Could be more or less, depending on screen size */
}

/* The Close span */
.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}

.menu {
  background: none !important;
  border: none;
  padding: 10 !important;
  /*optional*/
  font-family: arial, sans-serif;
  /*input has OS specific font-family*/
  color: #fff;
  text-decoration: none;
  cursor: pointer;
}

.summary {
  color: #263f73;
  font-size: 12px;
  padding: 2px;
}

.filter {
  border: none;
  background: none;
  text-decoration: none;
  padding: 0;
}

.card-header {
  border: none !important;
  background: none !important;
}

th,
a,
span,
div {
  font: normal normal normal 17px/1 FontAwesome;
}
input {
  border: 1px solid #ccc;
  height: 30px;
  padding-left: 8px;
}

.profile {
  color: #333;
  font-size: 10px;
  background: #ccc;
  padding: 5px;
}

.no-result-found {
  color: red;
}
```

##### src/components/home.jsx

```jsx
import React from "react";
import { toast } from "react-toastify";
export default class Home extends React.Component {
  callMe = (name) => {
    toast.info("hello " + name);
  };
  render() {
    return <h1 onClick={() => this.callMe("ian")}>Click Me</h1>;
  }
}
```

##### src/components/aboutus.jsx

```jsx
import React from "react";
export default class AboutUs extends React.Component {
  render() {
    return <div>this is a page about us</div>;
  }
}
```

### Bootstrap

npm i bootstrap
...
import "bootstrap/dist/css/bootstrap.css";
...

### Javascript

#### Error Handling

##### Async

<https://www.valentinog.com/blog/throw-async/>

```js
export function IngredientException(message) {
  this.message = message;
  this.name = "IngredientException";
}
...
async function saveIngredient() {
  ...
  throw new IngredientException("duplicate item " + ingredient.name);
  ...
}
...
    let { data: ingredient } = ingredientService
      .saveIngredient(body)
      .catch((err) => toast.error(err.message))
...
```

##### Sync

```js
...
throw (new Error('The message'));
...
try {
  doSomethingErrorProne();
} catch (e) {               
  console.error(e.name + " : " + e.message);    // logs 'Error'
}
```

### Higher Order Component (HOC)

#### HOC

* react snippet
  * hoc + tab
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

#### Main Component

* movie.jsx

```jsx
import withTooltip from "./withTooltip";
class Movie extends React.Component {
  render() {
    return <div>movies{this.props.showTooltip && "some tooltip"}</div>;
  }
}

export default withTooltip(Movie);
```

### useEffect

```jsx
...
function Users(props) {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    async function getUsers() {
      const result = await axios("https://jsonplaceholder.typicode.com/users");
      console.log(result.data);
      setUsers(result.data);
    }

    getUsers();
  }, []);

  return (
    <div>
      <ul>
        {users.map((user) => (
          ...
```

### useContext

#### Class Component

##### Context

```js
const UserContext = React.createContext();
UserContext.displayName = "UserContext";
```

##### Provider

```js
import UserContext from "./context/usercontext";
...
  state = { currentUser: { name: "ian" } };
...
      <UserContext.Provider value={this.state.currentUser}>
```

##### Consumer

```js
import UserContext from "./usercontext";
...
  static contextType = UserContext;
...
      <UserContext.Consumer>
        {(userctx) => (
          <div>
            {userctx.name}
            <MovieRow />
          </div>
        )}
      </UserContext.Consumer>
...
```

#### Functional Component (FFC)

##### Context

```js
import React from "react";
const UserContext = React.createContext();
UserContext.displayName = "UserContext";
export default UserContext;
```

##### Provider

```js
import UserContext from "./context/usercontext";
...
  state = { currentUser: { name: "ian" } };
 ...
  <UserContext.Provider value={this.state.currentUser}>
  ...
  <MoviePage />
```

##### Consumer

```js
import React, { useContext } from "react";
import UserContext from "./usercontext";
...
const currentUser = useContext(UserContext);
...
return <div>movierow: {currentUser.name}</div>;
...
```
