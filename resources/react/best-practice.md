---
layout: single
#classes: wide
title:  "React - Best Practice"
date:   2021-11-15 10:00:50 +0800
categories: react
allow_different_nesting: true
sidebar:
  nav: "react"
---

## Best Practice

### Tools

* use tools to help
  * visual studio code
  * extension
    * prettier
    * zencoding
      * use zencoding whenever possible
      * <http://www.cheat-sheets.org/saved-copy/ZenCodingCheatSheet.pdf>
    * Auto Import - ES6, TS, JSX, TSX
* react library
  * create-react-app
  * bootstrap@4.1.1
  * font-awesome@4.7.0
  * lodash@4.17.10
    * [lodash(pka underscore)](https://lodash.com/docs/)
  * query-string@6.1.0
  * joi-browser@13.4
    * form validation
      * .required().min(8).max(16).regex([a-z]?[A-Z]?[0-9](8,16)).label("Friendaly Name")
      * .optional()
  * axios@0.18
    * http client
      * object return has data; need to use object destructring (i.e. const {data} = axios.get(...))
  * react-toastify@4.1
    * replacing alert
  * sentry <https://sentry.io/auth/login/ianlow/>
    * do log error centrally to sentry.io
  * jwt-decode@2.2.0
    * to decode jwt
  * serve
    * lightweight web server
* sites
  * sentient
  * mlab
    * mongodb on cloud
  * heroku
    * application server

### coding practice

* import
  * organize your import in order below
    * third party library
    * custom compnent
    * css
* use let instead of var
* be familiar with [truthy](https://developer.mozilla.org/en-US/docs/Glossary/Truthy) and [falsy](https://developer.mozilla.org/en-US/docs/Glossary/Falsy)
  * E.g.
    * not null is considered truthy
    * undefined and null is considered falsy
* be careful with the use of && and ||
  * &&
    * will return right operand if left operand is truthy
  * ||
    * will return left operand if left operand is truthy, if falsy, then return right operand
* convention
  * function name
    * camelCase
    * starts with handle*
  * variable name
    * plural should append with s
    * utility class should use generic name such as item(e.g. handleItem vs handleMovie; itemCount vs movieCount)
* JSX returned by render method must consists of only 1 root element - encapsulate with \<div> or <react.fragment>
* use arrow function instead of constructor with binding to access "this"
* constructor
  * need to call super() first
* state should modified
  * only by component that owns it, OR
  * when there's parent/child component relationship, child should be a controlled component (no local state), and all value should entirely controlled by parent (value also should come from parent only)
    * parent should declare all the function and pass the reference to child
* when dealing with component list, always make sure "key" value is set, and always unique (since React render by comparing virtualdom and dom, it needs a unique id to compare)
* do not modify the state directly, always clone the state and setState(clone)
* using object as argument rather than literals when passing control from/to components
  * then, when there are new member in the object, no need to chnage code
* common items
  * design consideration
    * think of the input and callback
      * tableheader with sorting capability
        * E.g.
          * input
            * columns = [{key,path,label},...] // {1,"title","Title"}
            * sortState = {columnName, sortOrder} // title, desc
          * callback
            * handleSorting = f
  * should be coded in different js and export/import to promote usability
    * src/components/common/
    * src/utils/
  * name should be generic
  * property should have default value (Component.defaultProps = {key:defaultValue})
  * should not be tied to caller logic (e.g. item._id shoud le item[keyProperty] where keyProperty can be passed in caller)
* cleaner code
  * always destructure your arguments to make code cleaner
  * decoupling
    * decouple UI code from logic code(parent)
    * decouple high level code (\<Component/>) from low level code(\<table>\<tr>)

### Router

* router is not really routing
  * is more like render component at the defined location based on the path
  * \<Route> wrap component around and inject 3 props into component rendered
  * history
    * page navigation manipulation info (before, after)
      * e.g.
        * push
        * replace
  * location
    * current location info
  * match
    * info of matching path to route
* when using switch, always declare the more specific function/url first followed by less specific function/url
* parameters
* optional parameters is better as query parameter than url parameters
* window.location vs this.history.push
* full refresh - window.location

### Form

* always initialized controlled element state properties to string (cannot null or undefined)
* all react handler by default gets a [sytheticevent](https://reactjs.org/docs/events.html)
  * do not pass "this" to event handler (i.e. onChange={onChange(this)}) since "this" is refers to the dom itself
  * use Joi(joi-browser@13.4) to validate forms object
* structure

```jsx
...
  state = {
    data: { username: "", password: "" },
    errors: {},
  };
  schema = {
    username: Joi.string().required().label("User Name"),
    password: Joi.string().min(8).required().label("Password"),
  };
...
  doSubmit = async (data) => {
    try {
      // do somthing
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

### API

* use axios
* use optimistics rather than pessimistics update (i.e. update UI first, then call api)
  * UI looks more friendly
  * but need to implement logic the revert the state
* use axios.interceptors.response/request to ***prehandle condition globally***
* implement try/catch only for specific condition (e.g. when there's input parameter)
  * /api/posts - get all - no need since got error is unexpected (network, database)
  * /api/posts/1 - get specific - need to catch since client might pass in a wrong value (i.e. "1" doesn't exist in db)
* if you're getting info after an transaction(put/post/delete), make sure transaction is completed first before getting (e.g. use async/await to put, once "promised", then refresh UI)
* async and await comes in pair

### Deployment

* use different .env.[dev/sit/uat/stg/prd] to differentiate env parameters
* changes in .env need to restart server to take effect
* run app in heroku
  * set env vairableas and read from heroku env variables
    * heroku config: set key=value, OR
    * heroku app > settings > reveal config vars
  * then read from react
    * create prorudction.json

```json
{env-key:"val"}
```

### Advanced Topic

* use HOC (higher order component) to implment common functionality (e.g. tooltip)
  * HOC will
    * implement the common function and set the state the parent component
    * parent component will wrap around your component
* use FC if can (since code is shorter and cleaner)
  * useState
    * E.g.
      * var [count, setCount] = useState(0);{setCount(count++)}
  * useEffect
    * E.g.
      * useEffect(function, [dependency arrays])
        * useEffect(function)
          * run in all condition (mount, update, unmount)
        * useEffect(function, [])
          * run when mount, unmount
  * useContext
    * only for SFC
    * consumer code is much cleaner than CC