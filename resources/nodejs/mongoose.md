---
layout: single
classes: wide
title:  "Nodejs"
date:   2021-12-21 10:00:50 +0800
categories: react
allow_different_nesting: true
sidebar:
  nav: "react"
---

## Sample Code

### Import and create

```js
...
const mongoose = require("mongoose");

const dishSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    minlength: 3,
    maxlength: 50,
  },
  ...
  const Dish = mongoose.model("Dish", dishSchema);

function validateDish(Dish) {
  const schema = {
    name: Joi.string().min(3).max(50).required().label("Name"),
    ...
    exports.dishSchema = dishSchema;
exports.Dish = Dish;
exports.validate = validateDish;
...
```

### query

#### GET

| type     | code                                                        | description                                                   |
| :------- | :---------------------------------------------------------- | :------------------------------------------------------------ |
| mongoose | Dish.find()                                                 | find all                                                      |
| mongoose | Dish.find({_id:1,name:"ian"})                               | find with "AND" condition                                     |
| mongoose | Dish.findOne({ _id: req.params.id });                       | find 1 result                                                 |
| mongoose | Dish.find({$and: []}).select("-__v").sort("name");          | find with "AND" condtion; exclude "-__v" from result and sort |
| mongoose | Dish.find({$or: []}).select("-__v").sort("name");           | find with "OR" condtion; exclude "-__v" from result and sort  |
| mongoose | Dish.find({$all: []}).select("-__v").sort("name");          | find with "All" condtion; exclude "-__v" from result and sort |
| mongoose | Dish.find({name:{$regex:new RegExp(req.params.dish, "i")}}) | find using regex and case insensitive                         |

#### POST

```js
  let dish = new Dish({
    name: req.body.name,
    steps: req.body.steps,
    cuisine: req.body.cuisine,
    preparationTimeMin: req.body.preparationTimeMin,
    ingredientIds: req.body.ingredientIds,
  });
  dish = await dish.save();
```

#### PUT

```js
 const dish = await Dish.findByIdAndUpdate(
    req.params.id,
    {
      name: req.body.name,
      steps: req.body.steps,
      cuisine: req.body.cuisine,
      preparationTimeMin: req.body.preparationTimeMin,
      ingredientIds: req.body.ingredientIds,
    },
    {
      new: true,
    }
  );
```
