---
layout: single
title:  "Jekyll for Dummies!"
date:   2021-08-30 12:07:50 +0800
categories: jekyll update
toc: true
toc_label: "In this page"
toc_icon: " "
toc_sticky: true
sidebar:
  nav: "about"
---
## first things first

1. jekyll doesn't work if you are on vpn

## how to install quickly

1. you need ruby (mine was ruby 3.0.2p107)
2. goto workspace and run command below

```sh
gem install bundler jekyll
cd ~/dev/my-awesome-site
jekyll new .
bundle add webrick
bundle exec jekyll serve
```

### Reference

<https://highlandsolutions.com/blog/developing-with-jekyll-for-beginners>

## folder structure

* _config.yaml
  * configure the portal
  * custom variable can be created and reference from html using {{site.mycustomvariable}}
  * any changes is not auto reloaded (need to kill jekyll and run again)

### Reference

<https://highlandsolutions.com/blog/developing-with-jekyll-for-beginners>

## how to change theme

* find theme in [rubygem](https://rubygems.org/search?utf8=%E2%9C%93&query=jekyll-theme)
* edit project gemfile and add

```sh
gem "jekyll-theme-hacker"
```

* run "bundle install"
* edit .config.yml and add line below

```sh
theme: jekyll-theme-hacker
```

* start jekyll

### Minimal Mistake (Theme)

* highly customizable
* <https://mmistakes.github.io/>

### Reference

<https://www.inmotionhosting.com/support/website/jekyll/how-to-change-your-jekyll-theme-with-rubygems/>

## how to customize theme

1. identify your current theme (refer to config.yaml). E.g. jekyll-theme-minimal
2. run command below to figure out the path where the them is stored in your computer

```sh
bundle info --path jekyll-theme-minimal
```

1. open explorer and navigate to theme folder
1. copy _assests or _layouts to your project and modify accordingly

### Reference

<https://jekyllrb.com/docs/themes/>

## how to enable gui using plantuml

* download your own local plantuml server by running below
```sh
cd workspace
git clone https://github.com/plantuml/plantuml-server.git
mvn jetty:run
```
* make sure plantuml-server is running by visiting <http://localhost:8080/plantuml/>
* edit _config.yaml and add content below (this will point your ruby to local plantuml server above)

```txt
gems:
  - 'jekyll-plantuml-url'

plantuml:
  url:          'http://localhost:8080/plantuml' 
  type:         'svg'
  ssl_noverify: '0'
  http_debug:   '0'
```

* run "gem install jekyll-plantuml-url"
* add this line to the end of Gemfile

```txt
gem "jekyll-plantuml-url"
```

* start jekyll
* edit C:\Ruby30-x64\lib\ruby\gems\3.0.0\gems\jekyll-plantuml-url-0.1.3\lib\jekyll-plantuml-url.rb and remove "URI::encode" in line 84 (else jekyll cannot start)
  * this step is temporarily until a permanent solution is found
* edit markdown with content sample below

```txt
\{\% plantuml %}
Alice1 -> Bob1: hi
Bob1 -> Alice1: hihi
\{\% endplantuml %}
```

{% plantuml %}
Alice1 -> Bob1: hi
Bob1 -> Alice1: hihi
{% endplantuml %}

### Reference

<https://gitlab.com/dgoo2308/jekyll-plantuml-url>
<https://github.com/plantuml/plantuml-server>
