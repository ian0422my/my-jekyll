---
layout: single
#classes: wide
title:  "Code Quality"
date:   2021-10-04 11:00:50 +0800
categories: code quality, qa
toc: true
toc_label: "In this page"
toc_icon: " "
toc_sticky: true
sidebar:
  nav: "about"
---

## Summary

* there are many ways to ensure code quality
  * sonarqube
    * code smell
    * bug
    * security
  * maven checkstyle plugin
    * command
      * mvn checkstyle:checkstyle // check
      * mvn site // generate report

### SonarQube

#### Troubleshooting

##### Remote debug plugin using Eclipse

* enable port forward of port 8000:8000 in vagrant
* docker stop sonarqube1
* docker exec -it sonarqube1 /bin/bash
* vi /etc/sonarqube/conf/sonar.properties
* go to the last line and add below

```properties
sonar.web.javaAdditionalOpts=-agentlib:jdwp=transport=dt_socket,address=*:18000,server=y,suspend=n
```

* save the changes
* eclipse
  * create remote java debugging
    * port: 18000
  * debug java
