---
layout: single
#classes: wide
title:  "Github, Gitlab"
date:   2021-09-03 15:49:50 +0800
categories: Github, Gitlab
toc: true
toc_label: "In this page"
toc_icon: " "
toc_sticky: true
sidebar:
  nav: "about"
---

### create new local git project and push to github

```cmd
echo "# my-project" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/ian0422my/my-project.git
git push -u origin main
```

### push existing project to github

* goto github and add a new ***repository*** (make sure to set it private)

```cmd
git init --optional. only applies for non-git project
git remote add origin https://github.com/ian0422my/my-project.git -- confirm the changes by checking .git/config; modify the url manually if changes does not take effect
git branch -M main
git push -u origin main
```

### set git credentials

git config --global user.name "username"
git config --global user.password "password"
