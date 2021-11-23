---
layout: single
#classes: wide
title:  "React - Introduction"
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

## Introduction

* front-end (need backend to get data)
* library (not framework like angular)
* create by facebook

## Archtecture Design

* react will create virtual dom(based on code) and render as actual dom (html display on page)
* refresh automatically once code change is saved
  * hot module refresh -> that's why its call "React"
* object oriented
  * method
    * each method is object
* construct by component(reusable) - nav bar, login, menu, etc
  * need to export (E.g. export default Counter) to import
* content is written using
  * javascript
    * templating engine
      * loop
      * if/else
  * JSX (javascript xml) - \{}, \{\{}}
    * where jsx expression (E.g. \<span className="basic">) will be converted into javascript object
      * hence, "\<span className="basic"> cannot be written as \<span class="basic"> since "class" is a reserved keyword in javascript
    * not templating engine
      * no looping concept
      * no if/else
* Internal
  * babel
    * compile JSX into javascript
      * code > virtuadom > dom
  * create-react-app  
    * zero-config
  * ES6
    * new line
      * const
      * let

## Javascript Syntax

* like normal javascript
* method can return JSX
* class
  * extends Components
    * setState(state)
      * call this method to refresh the view
  * comprises of
    * state
      * each object has a state
        * initialize 1 time by object's state (i.e. state = {})
          * "state = {}" is just for initialization. this.state is referring to the state inside the object, not "state = {}".
      * will be overwritten after setState({})
    * render (method)
      * return jsx component
        * \<button className={}>, Or
        * text (E.g. "text")

## JSX Syntax

* javascript object
  * can be use like any other javascript like "let state = [like: \<Like/>]"

### \{}

* javascript expression
* E.g.
  * {2+2}
    * you get 4
  * \{this.state.count}
    * will display you declare in component's state.count
  * \{this.formatCount()}
    * call a function (e.g. formatCount() \{ return 'hi';}) and display value returned by the function
  * \<button onClick=\{() => this.handleFunction(param1, param2))}>Click</button>
    * passing a reference of a function(with parameter) to event
    * function will not be called until event is triggered
  * \<button onClick=\{this.handleFunction)}>Click</button>
    * passing a reference of a function(with no parameter) to event
    * function will not be called until event is triggered
  * \{\{}}
    * use as it is? native value?
  * \<Counter handleIncrement=\{this.handleIncrement}/>
    * passing control frmo parent to child via Counter.props

### Attributes

* jsx attribute is different from dom attributes
* E.g.
  * id
  * style
    * variable
      * styles1 = \{fontSize: 10} // property must be camelCase
      * style = \{this.styles1}
    * inline
      * style = \{\{fontSize: 80}}
  * className (not class)

### List

```jsx  
state = { 
      count: 0,
      tags: ['tag1','tag2','tag3']
    };

{this.state.tags.map(tag => <li key={tag}>{tag}</li>)}
```

### Inter-component communication

* (src)can include other component(target)
  * </Counter>
* (src)can pass value to target components
  * via target.props
    * src (i.e. Counters)
      * </Counter targetProps1="targetProps1Value">
    * target (i.e. Counter)
      * console.log(this.props.targetProps1); // log "targetProps1Value"
  * via target.children
    * src
      * \<Counter>\<h4>product name1</h4></Counter>
    * target
      * console.log(this.children); // log \<h4>product name1</h4>
* (src)can pass function(as object) to target components
  * via target.props
    * src (i.e. Counters)
      * \<Counter handleDelete={this.handleDeleteParent}>
    * target (i.e. Counter)
      * onClick={this.props.handleDelete}
* (src)can pass state(as object) to target components
  * via target.props
    * src (i.e. Counters)
      * \<Counter counters={this.counters}>
    * target (i.e. Counter)
      * console.log("id : " + {this.props.counters.id});