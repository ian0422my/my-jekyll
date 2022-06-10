---
layout: single
classes: wide
title:  "Splunk"
date:   2022-03-22 14:55:50 +0800
categories: splunk, monitoring
allow_different_nesting: true
sidebar:
  nav: "monitoring"
---

## Cheatsheet

* can search by regex
  * _raw is the raw content from the log
  * example below will filter the results and show only results that has NRIC

```cmd
host=picaaem10*p source="error.log" | regex _raw="[A-Z]{1}\d{7}[A-Z]{1}"
```

* to exclude

```cmd
NOT "somehting"
```
