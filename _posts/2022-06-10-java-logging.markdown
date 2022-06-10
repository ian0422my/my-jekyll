---
layout: single
#classes: wide
title:  "Java - Logging"
date:   2022-06-10 09:48:50 +0800
categories: aem
allow_different_nesting: true
toc: true
toc_label: "In this page"
toc_icon: " "
toc_sticky: true
sidebar:
  nav: "about"
---

## TLDR;

* slf4j
  * abstraction framework for logging implementation such as log4j1, log4j2, logback, tinylog, java.util.logging
* logback
  * revamp version of log4j1
  * natively implement slf4j-api
    * meaning can provide both implementation and abstract
      * implementation
        * logback
      * abstract
        * slf4j
* log4j2
  * enhancement of log4j
  * fixes some of the archicture issue not address by logback
* apache sling commons log
  * provide imlpemetation via logback

| framework                | package                      |
| :----------------------- | :--------------------------- |
| logback                  | ch.qos.logback               |
| java util logging, JUL   | java.util.logging            |
| log4j                    | org.apache.log4j             |
| log4j2                   | org.apache.log4j2            |
| slf4j                    | org.slf4j                    |
| apache sling commons log | org.apache.sling.commons.log |

## Summary

* abstract
  * slf4j
  * logback's slf4j
  * apache sling commons log's logback's slf4j
* implemenation
  * java util logging
  * log4j
  * log4j2
  * logback
  * apache sling commons log