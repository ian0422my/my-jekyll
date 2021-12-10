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

* srs = simple react snippet (visual studio code extension)

| type         | code                                                                                | description                                                                              |
| :----------- | :---------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------- |
| vscode,srs   | imrc > tab                                                                          | import react component                                                                   |
| vscode,srs   | cc > tab                                                                            | create class component skeleton                                                          |
| vscode,srs   | ccc > tab                                                                           | create class component with constructor                                                  |
| vscode,srs   | sfc > tab                                                                           | create stateless functional component skeleton                                           |
| vscode,srs   | table.table>thead>tr>td*4>h1+span.m-2[style="cursor:pointer"] + tab                 | generate table with thead,tr,4 Td, h1 and span(same lvl) with style; zen                 |
| vscode,srs   | log+tab -> console.log()                                                            |                                                                                          |
| vscode,srs   | error+tab -> console.error()                                                        |                                                                                          |
| vscode,srs   | warn+tab -> console.warn()                                                          |                                                                                          |
| vscode,srs   | loc+tab -> localstorage                                                             |                                                                                          |
| vscode,srs   | trycatch+tab -> try {} catch (ex) {}                                                |                                                                                          |
| vscode,srs   | cdm+tab -> componentDidMount(){}                                                    |                                                                                          |
| vscode,srs   | cdu+tab -> componentDidUpdate(){}                                                   |                                                                                          |
| vscode,srs   | cdun+tab -> componentWillUnmount(){}                                                |                                                                                          |
| css          | \<span className=\{\{m-2 col-2\}\}\/>\<span className=\{\{col\}\}>                  | 1st column occupy 2 column(grid system has 12 columns); 2nd span the rest of columns     |
| js           | let errors = { errors: errors \|\| {} }                                             | "\|\|" return left operand if left operand is truthy                                     |
| js           | let errors = { errors: errors && {} }                                               | "\|\|" return right operand if left operand is truthy                                    |
| js           | const counters = [...this.state.counters, {}]                                       | clone object array with additional object                                                |
| js           | totalCounters={this.state.counters.filter(c=>c.value>0).length}/>                   | copy with filtering condition and results in array object                                |
| js           | let person ={persons.filter(p=>p.name==="ian");                                     | copy with filtering condition and results in array object                                |
| js           | this.state.counters.map((counter)=>console.log(counter.id));                        | iterate                                                                                  |
| js           | async getMovies() { const {data:m} = await http.getMovies(); return m;}             | fetch data and return only when request is fulfilled (promised)                          |
| js           | try{...}catch(ex){if(ex.response.status===404)} {...}                               | check exception http status                                                              |
| js           | \<Route render={(p)=>if(login)return \<Route to="/login"/> else return \<Home/>}/>  | if else within expression                                                                |
| js,arr       | let movies={id:1,name:"2"}; Object.keys(movies).length                              | length of all keys of an object                                                          |
| js,arr       | const index = movies.indexOf(movie); const movie = movies[index];                   | getting the index of object in an array and get the object based on index                |
| js,arr       | const a1 = [1,2,3]; const a2 = [4,5,6];const combined = [...a1, 'a', ...a2, 'b'];   | combine array and new item                                                               |
| js,arr       | item={id:"1", name:"ian"}; key="id";item[key] == 1;//true                           | access value of items dynamically by name(i.e. no hardcode like item.id)                 |
| js,arr       | let name="id";let property = { [name]: value };                                     | create object with dynamic key                                                           |
| js,arr       | let movies=[];movie={};movies.push(movie);                                          | add object in array                                                                      |
| js,arr       | let movies={id:1}; delete movies._id                                                | remove key from array                                                                    |
| js,browser   | localStorage.setItem('token',jwt)                                                   | store value in browser's local storage                                                   |
| js,browser   | localStorage.getItem("token")                                                       |                                                                                          |
| js,browser   | localStorage.deleteItem("token)                                                     |                                                                                          |
| lodash       | let pages = lodash.range(min, max);                                                 | create array with min, max size                                                          |
| lodash       | _(items).slice(startIndex).take(pageSize).value()                                   | cut a chuck sizes(pageSize) of items from start(index)                                   |
| lodash       | const sortedMovies = _.orderBy(array,["field1",...],["asc"];                        | sorting array                                                                            |
| lodash       | _.get(object, path)                                                                 | get object member by path                                                                |
| joi          | schema = {uname: Joi.required()};let errors = Joi.validate({uname:""}, schema)      | define Joi schema,validate object and return validation message with friendly name       |
| joi          | schema={id: Joi.allow('')};                                                         | allow empty                                                                              |
| axios        | const { data: posts } = await axios.get(getEndpoint);                               | get from rest api                                                                        |
| axios        | const { data: post } = await http.post(postEndpoint, { title: "a", body: "b" });    | add; post to rest api with body                                                          |
| axios        | const data = await http.patch(putEndpoint + "/" + post.id, {title: post.title});    | update; update a single property of an object(post update the whole object)              |
| axios        | const data = await http.put(putEndpoint + "/" + post.id, post);                     | update; update an object                                                                 |
| toast        | toast.error("error!!!");                                                            | display error using toast notification                                                   |
| query-string | npm i query-string@6.1.0; queryString.parse(location.search);                       | parse queryString as object                                                              |
| jwt-decode   | const user = jwtDecode(jwt);                                                        |                                                                                          |
| react        | svc1.js>export function m1(){};import * as svc1 from './svc1.js';svc1.m1();         | export a service, and import all service                                                 |
| react        | auth.js>function m1(){};export default {m1} - import auth from 'auth'; auth.m1()    | export module; import module and invoke function                                         |
| react        | this.setState({counters});                                                          | update state and refresh the view                                                        |
| react        | {error && \<div className="alert alert-danger">{error}</div>}                       | show when "error" is not null                                                            |
| react        | React.Fragment                                                                      | create component without div                                                             |
| react        | const {handleReset, counters} = this.props; handleReset();                          | destructing argument                                                                     |
| react        | const {handleReset: customVarName} = this.props; customVarName();                   | destructing argument with custom variable name                                           |
| react        | onClick={() => handleReset(this.state.counters)}                                    | pass reference to a method with arg                                                      |
| react        | state={m1: name => \<h1>welcome {name}</h1>}; \<Profile m1={this.state.m1}/>        | pass reference to a method with arg as object member                                     |
| react        | onClick={handleReset}                                                               | pass reference to a method without arg                                                   |
| react        | parent - \<Counter total=1>; child - this.props.total                               | passing value from parent to child                                                       |
| react        | parent - \<Counter fn1={fn1}>; child - this.props.fn1()                             | passing method(no arg) reference from parent to child                                    |
| react        | parent - \<Counter fn1={fn1}>; child - () => this.props.fn1(param1,param2)          | passing method(with arg) reference from parent to child                                  |
| react        | this.setState({movie}); // rather than {movie:movie}.                               | ecma6; use when key=value;shorter and cleaner code                                       |
| react        | Pagination.propTypes = {itemCount: PropTypes.number.isRequired}                     | enforce type - number and required - for a class member                                  |
| react        | MyComponent.defaultProps = { customProp: "default value"}                           | set default value for props member                                                       |
| react,rrd    | \<Link to="/path"/>                                                                 | ui; change url without reloading bundle.js                                               |
| react,rrd    | \<NavLink to="/path">                                                               | ui; change url; highlight automatically once clicked                                     |
| react,rrd    | \<Switch/>\<Route/>                                                                 | routing; render component based on path. If match, stop processing the rest              |
| react,rrd    | \<Route path="/path" component="Products"/>                                         | routing; render component based on path with existing props                              |
| react,rrd    | \<Route render={(props)=>\<Product name={name} {...props}/>}/>; this.props.name;    | routing; render component based on path with additonal(name) and existing props          |
| react,rrd    | \<Route path="/posts/:year?" component={Posts} />; year=this.props.match.param.year | routing; path with optional parameters                                                   |
| react,rrd    | render() \{return \<Redirect to="/home"/>}                                          | routing; redirect                                                                        |
| react,rrd    | \<Redirect from="/" to="/"/>                                                        | routing; redirect                                                                        |
| react,rrd    | \<Redirect from="/" to={{pathname:"/login",state:{here: this.props.location}}}/>    | routing;redirect to path(with existing props;access using this.props.location.state.here |
| react,rrd    | http://url/?year - let {year} = queryString.parse(this.props.location.search);      | read query param                                                                         |
| react,rrd    | http://url/:year/ - let year = this.props.match.params.year                         | read url param                                                                           |
| react,rrd    | this.props.history.replace(url)                                                     | change browser url without history                                                       |
| react,rrd    | this.props.history.push(url)                                                        | change browser url with history                                                          |
| react        | \<form onSubmit=\{this.handleSubmit\}>\<button name="Login"/>                       | submit form                                                                              |
| react        | \<input onChange=\{this.onChange\}/>;onChange(e) {}                                 | call function when input changes                                                         |
| react        | \<select onChange=\{this.onChange}>/>;onChange(e) {}                                | call function when select changes                                                        |
| react        | .env.production.json>REACT_APP_NAME=vidly>console.log(process.env.REACT_APP_NAME)   | creat environemnt specific json and read the value (must start with REACT_APP_*)         |
| react,serve  | npm run build; npm i -g serve; serve -s build                                       | build prod("build") folder;install lightweight webserver;run prod app in "build" folder  |
| react,heroku | heroku create --buildpack https://github.com/mars/create-react-app-buildpack.git    | create heroku app for created using create-react-app                                     |
| react,heroku | cd vidly;heroku create; git push heroku master; heroku open                         | create heroku app; push code to heroku git repo and build; open heroku app in browser    |
| react,heroku | heroku tail [--tail]                                                                | open/tail heroku logs                                                                    |
| react,heroku | heroku config:get NODE_ENV -a blooming-beyond-16719                                 | check config                                                                             |
| react,heroku | heroku config:set envkey=envval                                                     | create environment variables (aslo can do so via app > settings > reveal config vars)    |
| react,heroku | heroku restart                                                                      | restart heroku app                                                                       |
| react,heroku | heroku maintenance:on/off                                                           | kind of bring down the app                                                               |
| react,adv    | npx create-react-app react-advanced                                                 | create react app using npx                                                               |
| react,adv    | return class WithTooltip extends React.Component {render(){}}                       | create class component as a return object                                                |
| react,adv    | var [count, setCount] = useState(0);{setCount(count++)}                             | hook - useState (setState for CC)                                                        |
| react,adv    | useEffect(function, [dependency arrays])                                            | hook - useEffect (componentDidMount,componentDidUpdate,componentWillUnmount for CC)      |

## Snippet

### Higher Order Component (HOC)

#### HOC

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

### Context

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

#### Functional Component

##### Context

```js
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
```

##### consumer

```js
import React, { useContext } from "react";
import UserContext from "./usercontext";
...
const currentUser = useContext(UserContext);
...
return <div>movierow: {currentUser.name}</div>;
...
```
