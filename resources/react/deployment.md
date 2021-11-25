---
layout: single
# classes: wide
title:  "React - Deployment"
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

## Deployment

* deploy to heroku

### 2 - Environment Variables

* create environment variables files for different environment
  * changes in .env will only take effect after restart
  * kvp
  * must prefix with REACT_APP_*
  * accessible through process.env.*
    * actual value will be replced into bundles.js (not process.env)
* create
  * vidly/.env
  * vidly/.env.development
* add value
  * REACT_APP_NAME=vidly in dev
  * REACT_APP_VERSION=1
* index.js

```js
...
console.log(process.env);
console.log(process.env.REACT_APP_NAME);
...
```

### 3 - Production Builds

* development
  * npm start and run with .env.development
    * will build non-optimized code
      * consists of code to enable debugging
* production
  * npm run build
    * this will build production optimized code (i.e. vidly/build/)
  * run with .env.production
    * npm i -g server
    * serve -s build

### 4 - getting started with heroku

* create account in heroku
* install heroku cli
* login
  * will bring you to browser for login

```cmd
heroku login
```

### 5 - mongodb in cloud

* use <https://mlab.com/>
  * create user
    * admin/admin
  * create cluster
  * create database
    * vidly
  * create collections(tables)
    * name: genres
    * add documents (record)
      * name: action
      * name: thriller
      * name: romance

```txt
const { MongoClient } = require('mongodb');
const uri = "mongodb+srv://<username>:<password>@cluster0.xrjbg.mongodb.net/myFirstDatabase?retryWrites=true&w=majority";
const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });
client.connect(err => {
  const collection = client.db("test").collection("devices");
  // perform actions on the collection object
  client.close();
});
```

### 7 - deploying to heroku

* cd vidly-api-node
* create heroku app

```cmd
heroku create
```

* you'll get a random name
  * https://stormy-scrubland-16093.herokuapp.com/
* your code can be push to git repo below
  * https://git.heroku.com/stormy-scrubland-16093.git
* push code to git
  * once push, heroku will be notified and pull the latest code

```cmd
git push heroku master
```

* launch application
  
```cmd
heroku open
```

* visit app @ <https://stormy-scrubland-16093.herokuapp.com/>

### 8 - Viewing Logs

* goto <https://dashboard.heroku.com/apps/stormy-scrubland-16093/logs>, or "heroku logs"

### 9 - setting env variables on heroku

* get mongodb connection url
  * cluster > collections > cmd line tools > connect to your cluster > connect your application > node.js + 4.0 or later

```txt
const { MongoClient } = require('mongodb');
const uri = "mongodb+srv://admin:<password>@cluster0.xrjbg.mongodb.net/myFirstDatabase?retryWrites=true&w=majority";
const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });
client.connect(err => {
  const collection = client.db("test").collection("devices");
  // perform actions on the collection object
  client.close();
});
```

* node,node.js 2.2.12 or later

```txt
mongodb://admin:admin@cluster0-shard-00-00.xrjbg.mongodb.net:27017,cluster0-shard-00-01.xrjbg.mongodb.net:27017,cluster0-shard-00-02.xrjbg.mongodb.net:27017/myFirstDatabase?ssl=true&replicaSet=atlas-nir4bg-shard-0&authSource=admin&retryWrites=true&w=majority
```

* set to heroku env var
  * goto heroku app > settings > reveal config vars
    * add 
      * key: vidly_db
      * value: <value on top>
    * save the changes
  * or, use cli (not working)

```cmd
heroku config:set vidly_db=mongodb://admin:admin@cluster0-shard-00-00.xrjbg.mongodb.net:27017,cluster0-shard-00-01.xrjbg.mongodb.net:27017,cluster0-shard-00-02.xrjbg.mongodb.net:27017/vidly?ssl=true&replicaSet=atlas-nir4bg-shard-0&authSource=admin&retryWrites=true&w=majority
```

* add vidly-api-node/config/production.json
  * dev read from default.json, the rest read from custom-environment-variables.json

```json
...
"db": "vidly_db"
...
```

* push code to git

```cmd
git add *
git commit -m "add support for env var"
git push heroku master
```

* start app

```cmd
heroku open
```

* verify app @ @ <https://stormy-scrubland-16093.herokuapp.com/api/genres>