---
layout: single
#classes: wide
title:  "markdown vs markup"
date:   2022-07-19 15:29:50 +0800
categories: mindmap
allow_different_nesting: true
toc: true
toc_label: "In this page"
toc_icon: " "
toc_sticky: true
sidebar:
  nav: "about"
---

## terminology

### headless

* front end and backend is decouple
  * backend info is exposed via rest api as json format
  * up to front end to decide how to present

### markup

* markup means to perform font editing
* synonym to markdown

#### YAML vs JSON

|                                 | yaml                                | json*        |
| :------------------------------ | :---------------------------------- | :----------- |
| format                          | indentation                         | curly braces |
| readability                     | easier than json                    | -            |
| easy to maintain doc?           | harder than json                    |              |
| unique element?                 | yes                                 | no           |
| cross reference within document | yes                                 | no           |
| performance                     | slower than json since more feature | faster       |

* Legends

```txt
* json is the subset of javascript which is familiar to most of thre javascript developers.
```
