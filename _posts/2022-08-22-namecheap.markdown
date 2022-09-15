---
layout: single
#classes: wide
title:  "Namecheap"
date:   2022-08-22 13:29:50 +0800
categories: namecheap, dns
allow_different_nesting: true
toc: true
toc_label: "In this page"
toc_icon: " "
toc_sticky: true
sidebar:
  nav: "about"
---

## summary

* some domain is very cheap
* `host` + `domain` = `FQDN`
  * example
    * host = my-first-jekyll
    * domain = ian0422my.xyz
    * qdn = my-first-jekyll.ian0422my.xyz
* record (domain > manage > advnaced > add new record)

| type  | format         | description                                                                                                         |
| :---- | :------------- | :------------------------------------------------------------------------------------------------------------------ |
| A     | domain->ipv4   | resolved to ip                                                                                                      |
| AAAA  | domain->ipv6   | resolved to ip                                                                                                      |
| cname | domain->domain | ip of the target domain will be copied to source domain; if target ip is changed, then source domain might not work |
| alias | domain->domain | dsad                                                                                                                |
