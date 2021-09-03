---
layout: single
classes: wide
title:  "Minimal Mistakes Theme (jekyll)"
date:   2021-08-30 11:05:50 +0800
categories: minimal mistake theme
toc: false
toc_label: "In this page"
toc_icon: " "
toc_sticky: true
sidebar:
  nav: "about"
---

# navigation

* main - top menu
* custom navigation can be created and reference in page
```yaml
sidebar:
  nav: "about"
```

# page section

* configure this on top of your page
```yaml
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
```

## Reference

<https://mmistakes.github.io/>

