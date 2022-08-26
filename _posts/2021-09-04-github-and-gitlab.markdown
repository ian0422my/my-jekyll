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

## Git

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

```cmd
git config --global user.name "ian0422my"
git config --global user.email "ian0422my@gmail.com"
git config --global user.password "password" // if enable 2fa, then need to create personal access token
```

## GitLabs

* can be installed using docker

```sh
sudo mkdir /srv/gitlab
sudo docker network add xdlab
sudo ufw allow 18080 // open firewall
sudo ufw allow 18443 // open firewall
sudo ufw allow 18022 // open firewall
export GITLAB_HOME=/srv/gitlab
sudo docker run --detach --publish 18443:443 --publish 18080:80 --publish 18022:22 --name gitlab --restart always --volume $GITLAB_HOME/config:/etc/gitlab --volume $GITLAB_HOME/logs:/var/log/gitlab --volume $GITLAB_HOME/data:/var/opt/gitlab --shm-size 256m --network myxdlab gitlab/gitlab-ee:latest 
sudo docker logs -f gitlab // instllation take very long. need to tail
sudo docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password // hVLQaMMYhI8SwXMKHx9pIAXAs9xwkXUGhCsg9Y7rVQY=
```

### Gitlab Runner

* module to help execute CICD jobs (based on .gitlab-ci.yml) for gitlab project
* executor can be docker(which eventually will pull ruby:2.7 to executes CICD)
