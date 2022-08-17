---
layout: single
classes: wide
title:  "Nodejs"
date:   2021-12-21 10:00:50 +0800
categories: nodejs,npm
allow_different_nesting: true
sidebar:
  nav: "nodejs"
---

## CLI

| cmd                                                                                 | description                    | remarks                                                               |
| :---------------------------------------------------------------------------------- | :----------------------------- | :-------------------------------------------------------------------- |
| initialize                                                                          | npm init [--yes]               | will create package.json                                              |
| install specific module/dependencies into `/node_modules`                           | npm i [module] --save          | `--save*` will update package.json(not needed if npm version > 5.0.0) |
| install all dependencies needed for production env(dependencies)                    | npm i --save                   |                                                                       |
| install all dependencies needed for development env(devDependencies). E.g. eslint   | npm i --save-dev               |                                                                       |
| install all optionalDependencies(ignore if fail to install). E.g. color for console | npm i --save-optional          |                                                                       |
| list local [package] dependencies                                                   | npm list [package] [--depth=N] |                                                                       |

## modules

### config

#### windows

##### cmd

```cmd
set NODE_ENV="production"
node index.js
```

##### powershell

<https://www.npmjs.com/package/config>

```cmd
$env:vidly_db="mongodb://admin:admin@cluster0-shard-00-00.xrjbg.mongodb.net:27017,cluster0-shard-00-01.xrjbg.mongodb.net:27017,cluster0-shard-00-02.xrjbg.mongodb.net:27017/vidly?ssl=true&replicaSet=atlas-nir4bg-shard-0&authSource=admin&retryWrites=true"
$env:vidly_db="mongodb://admin:admin@cluster0-shard-00-00.xrjbg.mongodb.net:27017,cluster0-shard-00-01.xrjbg.mongodb.net:27017,cluster0-shard-00-02.xrjbg.mongodb.net:27017/vidly?ssl=true&replicaSet=atlas-nir4bg-shard-0&authSource=admin"
 $env:NODE_ENV="production"
node index.js
```

## Libraries

| name               | description                                           |
| :----------------- | :---------------------------------------------------- |
| mongoose           | to access mongodb                                     |
| bcrypt             | encryption                                            |
| joi-browser        | validate input                                        |
| axios              | http                                                  |
| express            | web application framework                             |
| router             | map endpoints to method                               |
| lodash             | array utility                                         |
| express-formidable | to process formdata into request.field, request.files |
| aws-sdk            |                                                       |
| nodemailer         | send email                                            |
| eslint             | code clean                                            |

### Sample Code

#### joi-browser

```js
      schema: {
        username: Joi.string().min(8).label("User Name"),
        password: Joi.string()
          .regex(/[a-zA-Z0-9]{8,30}/)
          .min(8)
          .max(30)
          .required()
          .error(() => {
            return {
              message: "password entered does not fulfill requirement.",
            };
          })
          .label("Password"),
      },
```

#### express

##### Basic Routing

```js
var express = require('express')
var app = express()
const port = 3000

// respond with "hello world" when a GET request is made to the homepage
app.get('/', function (req, res) {
  res.send('hello world')
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})
```

##### chainable route

* modular routes (same path)
* birds.js

```js
var express = require('express')
var router = express.Router()

// define the home page route
router.get('/', function (req, res) {
  res.send('Birds home page')
})
// define the about route
router.get('/about', function (req, res) {
  res.send('About birds')
})

module.exports = router
```

* router.js

```js
var birds = require('./birds')
app.use('/birds', birds)
```

#### mongoose

* model

```js
...
const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    minlength: 2,
    maxlength: 50
  },
  ...
  const User = mongoose.model("User", userSchema);
  ...

```

* router

```js
...
const { User, validate } = require("../models/user");
...
  const user = await User.findById(req.user._id).select("-password");
  res.send(user);
...
  user = new User(_.pick(req.body, ["name", "email", "password"]));
...
  await user.save();
...
```

#### express-formidable

<https://www.w3schools.com/nodejs/nodejs_uploadfiles.asp>

* provider

```js
npm i express-formidable
...
const formidable = require("express-formidable");
app.use("/api/ingredients/image", formidable());
...
router.post("/image", auth, async (req, res) => {
  let image = req.files.image;
  var oldpath = image.path;
  ...
```

* consumer

```js
...
    const formData = new FormData();
    formData.append("image", event.target.files[0]);
...
  const config = {
    headers: {
      "content-type": "multipart/form-data",
    },
  };
  const { data: newDishInDb } = await httpService.post(
    endpoint + "/image",
    formData,
    config
  );
  ...

```

#### nodemailer

<https://jasonwatmore.com/post/2020/07/20/nodejs-send-emails-via-smtp-with-nodemailer>

* npm install nodemailer

##### Ethereal - fake smtp; but still allowed you to view email you sent

* create free [etherreal account](https://ethereal.email/create) - 
  * account info

| key      | value                           |
| :------- | :------------------------------ |
| Host     | smtp.ethereal.email             |
| Port     | 587                             |
| Security | STARTTLS                        |
| Username | eweqjoxnbws5nw7z@ethereal.email |
| Password | eAykGrwmhyS9DDdhpt              |

* sample code

```js
const transporter = nodemailer.createTransport({
    host: 'smtp.ethereal.email',
    port: 587,
    auth: {
        user: 'eweqjoxnbws5nw7z@ethereal.email',
        pass: 'eAykGrwmhyS9DDdhpt'
    }
});

await transporter.sendMail({
    from: 'from_address@example.com',
    to: 'to_address@example.com',
    subject: 'Test Email Subject',
    html: '<h1>Example HTML Message Body</h1>'
});
```

##### Gmail

<https://stackoverflow.com/questions/19877246/nodemailer-with-gmail-and-nodejs>

* need gmail account and set "Access for less secure apps setting" to "On"

```js
const transporter = nodemailer.createTransport({
    host: 'smtp.gmail.email',
    port: 587,
    auth: {
        user: <user email>,
        pass: <user password>
    }
});
```
