---
title: About
permalink: /about/
#classes: wide
layout: single # compress, single. archive, posts(taxonomy), categories(taxonomy),tags(taxonomy),collection(taxonomy),home(page), splash
toc: true # only works for "layout: single"
toc_label: "In this page"
toc_icon: "cog"
toc_sticky: true
sidebar:
  nav: "about"
---

## Build and Run

* this is a jekyll project which relies on plantuml-server
* this project can be run
  * manually
    * run plantuml-server/run.bat
    * run my-jekyll/run.bat
  * docker compose
    * docker-compose up [-d]
    * docker-compose down
    * which depends on image
      * ian0422my/plantuml-server-jetty
        * skipped codestyle checking
        * code change
      * bretfisher/jekyll-server

Docker Image

* ian0422my/plantuml-server
  * docker image build -t ian0422my/plantuml-server .
  * docker login
  * docker push

This is the base Jekyll theme. You can find out more info about customizing your Jekyll theme, as well as basic Jekyll usage documentation at [jekyllrb.com](https://jekyllrb.com/)

## Minima

You can find the source code for Minima at GitHub:
[jekyll][jekyll-organization] /
[minima](https://github.com/jekyll/minima)

## Jekyll

You can find the source code for Jekyll at GitHub:
[jekyll][jekyll-organization] /
[jekyll](https://github.com/jekyll/jekyll)

[jekyll-organization]: https://github.com/jekyll

## Minimal Mistakes

<https://mmistakes.github.io/minimal-mistakes>



