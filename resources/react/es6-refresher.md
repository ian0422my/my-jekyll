---
layout: single
#classes: wide
title:  "React - ES6 Refresher"
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

## ES6 Refresher

### var vs let const

* var

```js
function test() {
  for(var i = 0;i<5;i++) {
    console.log(i); // i is accessible
  }
  console.log(i); // i is accessible
}
```

* let

```js
function test() {
  for(let i = 0;i<5;i++) {
    console.log(i); // i is accessible
  }
  console.log(i); // i is NOT accessible
}
```

* const

const i = 1;
i = i++; // compilation error since const is read only

#### Comparison

| command | scope    | read? write? | remarks                            |
| :------ | :------- | :----------- | :--------------------------------- |
| var     | function | read/write   | try to not use this                |
| let     | block    | read/write   | like java; use this instead of var |
| const   | block    | read only    |                                    |

### This

* return object if called within method
* return window is called outside of method

```js
person = {
  walk() {
    console.log(this);
  }
}

person.walk(); // this will refer to the object
const walk = person.walk;
walk(); // this will be undefined(strict mdoe) or window object(non-strict mode)
```

### Bind

```js
person = {
  walk() {
    console.log(this);
  }
}

const walk = person.walk.bind(person);

walk();// this will return person
```

### Arrow Function - (=>)

* ecma6 only
* arrow function inherits "this"

#### promote shorter and cleaner code

* by removing "function" and "return"

##### Example 1

```js
// old code
const square = function(number) {
  return number*number;
}

// new code
const square = (number) => number*number
const square = number => number*number // if single arg
```

##### Example 2

```js
const jobs = [
  {id:1. isActive:true},
  {id:2. isActive:true},  
]

// old
const activeJobs = jobs.filter(function(job){return job.isActive;})
// new
const activeJobs = jobs.filter(job=>job.isActive);
```

#### Reference a method with parameter

##### Example 1

```js
onClick={() => this.props.handleIncrement(this.props.counter)}
```

### Map(method) - array.map(o=>...)

* ecma6 only

```js
const colors = ["green","blue","red"];
colors.map(color=>'<div>'+color+'</div>');
// template literal (`` and ${var})
colors.map(color=>`<div>${color}</div>`);
```

### Object destructring - const {member} = object

* instead of calling this.props. multiple times in counters.jsx, we can destructure the argemnets
  * from
    * <Counter handleIncrement={this.props.handleIncrement} handleReset={this.handleReset}>
  * to
    * const {handleIncrement, handleReset} = this.props;
    * <Counter handleIncrement={handleIncrement} handleReset={handleReset}>

### Spread Operator - {...}

* ecma6

#### combine array

```js
const first = [1,2,3]; const second = [4,5,6];
//old
const combined = first.concat(second);
//new
const combined = [...first, 'a', ...second, 'b'];
```

#### clone array

```js
state = [[]];
const counters = [...this.state.counters];
```

#### combine object

```js
const first = {"name": "ian"};
const second = {"job": "programmer"};

const combined = {...first, ...second, "location": "singapore"};
```

#### clone object

``js
const first = {"name": "ian"};
const second = {...first};
``

### Classes (class)

* create blue print

```js
class Person {
  constructor(name) 
    this.name = name;
  }
  walk() {
    console.log(this.name, "walk");
  }
}

const ian = new Person("ian");
const john = new Person("john");
```

### Inheritance(extends)

* extends base class
  * child constructor need to call super constructor

```js
class Teacher extends Person {
  constructor(name, degree) {
    super(name);
    this.degree = degree;
  }
}

const teacher1 = new Teacher("marry", "master of science");

teacher1.walk();
```

### Modularity

* es6
* save each class into different file
  * export to make it public
  * import(by relative path) to use
* Person.js

```js
export class Person {
  constructor(name) 
    this.name = name;
  }
  walk() {
    console.log(this.name, "walk");
  }
}
```

* teacher.js

```js
import { Teacher} from "./teacher"
class Teacher extends Person {
  constructor(name, degree) {
    super(name);
    this.degree = degree;
  }
}
```

### Export/Import

* es6

| export syntax                     | import syntax              |
| :-------------------------------- | :------------------------- |
| export default class/function ... | import ... from 'module'   |
| export class/function ...         | import {...} from 'module' |

### Setting up vidly project

* create-react-app vidly
* cd vidly
* npm i bootstrap@4.1.1 font-awesome@4.7.0
* goto getbootstrap.com > examples > find starter template > right clikc view source > find "container" and copy the <main> dom
* edit index.js

```js
import "bootstrap/dist/css/bootstrap.css";
import "font-awesome/css/font-awesome.css";
```

* edit app.js

```js
function App() {
  return <main className="container">hello world</main>;
}
```

* download <https://cdn.fs.teachablecdn.com/TozKsswWRDS1wbUQTgew>
* extract to services/ folder
  * services/fakeGenreService.js
  * sefvices/fakeMovieService.js
    * _id is the default id column in MongoDB