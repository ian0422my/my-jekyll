---
layout: single
classes: wide
title:  "Netlify and Jamstack"
date:   2021-09-03 15:49:50 +0800
categories: netlify, jamstack
toc: false
toc_label: "In this page"
toc_icon: " "
toc_sticky: true
sidebar:
  nav: "about"
---

## netlify

* supports auto deploy (based on changes in file) using jekyll

### How to push github project to netlify

* login to netlify using github account
* create jeklly-base project through netlify (e.g. https://github.com/ian0422my/jekyll-base)
* modify README.md (e.g. https://github.com/ian0422my/jekyll-base/tree-save/master/README.md)
* go to netlify and deploy
* preview (e.g. https://focused-agnesi-dc5095.netlify.app/)

## jekyll

* static site generator; ruby; convert MD to HTML;
* can host html (web server)
* liquid
	* templating language to process pages
* need index.html
* need to build (jekyll build) before can host (jekyll serve @ http://localhost:4000)
* few gem need to be install @  Developing with Jekyll for Beginners - Highland (highlandsolutions.com)
* gem install public_suffix --version 3.0.1
```cmd
gem install bundler jekyll
cd ~/dev/my-awesome-site
jekyll new .
bundle exec jekyll serve
```

* _config.yaml - configure the portal; custom variable can be created and reference from html sing {{site.mycustomvariable}}
* structure
	* _config.yaml
		* configure the portal; custom variable can be created and reference from html using {{site.mycustomvariable}}
			* any changes is not auto reloaded (need to kill jekyll and run again)
  		* theme: minima(default); can be change;
