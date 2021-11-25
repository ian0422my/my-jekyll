---
layout: single
#classes: wide
title:  "AWS Cloud Search"
date:   2021-11-22 16:00:50 +0800
categories: aws
allow_different_nesting: true
toc: true
toc_label: "In this page"
toc_icon: " "
toc_sticky: true
sidebar:
  nav: "about"
---

## AWS Cloud Search

* aws managed service

### search engine

* search domain
  * search instance(s)
    * data + hardware + software
    * types
      * search.m1.small - 2 mil docs (default)
      * search.m1.large - 8 mil docs
      * search.m2.xlarge - 16 mil docs
      * search.m2.2xlarge - 32 mil docs

### scalability

* scale up or down depending on
  * query rate
    * vertical followed by horizontal
      * small to largest
      * if largest not enough, then create multiple search instance
  * search index
    * horizontal
      * if execeed 2xlarge, then aws increase search instance and split the index

### indexing

* each field can be configured to be
  * searchable
  * sortable
  * highlightable
  * facet enabled
  * return enabled?

### APIs

#### configuration

* architecture related
  * scaling
    * prescale search domain by desired instance type
  * availability
    * deploy domain across 2 AZ
* indexing related
  * text analysis
    * configure processing option (E.g. stopwords, stemming)
  * indexing
    * configure what to index
* query related
  * suggesters
    * suggest possible matches for incomplete query
  * expressions
    * contorl how search results are ranked
      * default relevance score
        * frequeuncies of search terms within a documents
          * more occurancs means higher relevance score


#### document

* modify searchable data

#### search

* handles search and suggestion requests
* returns a list of matching documents

### cloud base search

* features
  * topic???
  * taggin???
  * keyword???
  * category???
  * ranking???
  * document index???
