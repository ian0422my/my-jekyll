---
layout: single
#classes: wide
title:  "Visual Studio Code"
date:   2021-09-22 16:44:50 +0800
categories: visual studio code
toc: true
toc_label: "In this page"
toc_icon: " "
toc_sticky: true
sidebar:
  nav: "about"
---

## Purpose

* text editor with lots of plugin/extension
* features
  * git
* extension
  * project manager
  * markdown all in one
    * can format whole document (e.g. table)
  * markdownlint
  * Docker
    * makes docker coding a breeze
      * Example
        * auto suggest on docker image
        * ***UI to direct browsing of container's file system*** (e.g. /app, /bin, /etc)
* written using nodejs

## Useful settings

* format on save
* tab space = 4
  * edit a file
  * click on the spaces (status bar)
  * change to 2

## Shortcuts

<https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf>

| shortcut                                 | description                                                                          |
| :--------------------------------------- | :----------------------------------------------------------------------------------- |
| ctrl+,                                   | settings                                                                             |
| ctrl+d                                   | select same pattern(run again to select more)                                        |
| ctrl+g                                   | go to line                                                                           |
| alt+click                                | select multiple location(to edit multiple location)                                  |
| shift+alt+[up/down]                      | copy existing line up/down                                                           |
| shift+delete                             | delete line                                                                          |
| table.table>thead>tr>td*4>span.m-2 + tab | this will generate a table with thead, tr, 4 Td - Zencoding (using css class syntax) |
| select line(s) + alt + up/down           | move the line up/down (no need cut/paste)                                            |
| ctrl+p                                   | find files; can use regex;                                                           |
| ctlr+p > @<method name>                  | find and go to method                                                                |
| ctrl+click                               | goto method                                                                          |

## language support

### java

* install language support for java @ <https://marketplace.visualstudio.com/items?itemName=redhat.java>

## Troubleshoot

### Slow when loading or editing

* disable git auto refresh (Settings > Extension > Git > Autorefresh)
* debug using Process Explorer (Help > Open Process Explorer)
* either
  * don't try to open a folder with alot of git project (else, vsc will keep running alot of git process at the background) at the "Source Control", OR
  * you can ignore some of the git project (Settings > git.ignoredRepositories)
* don't put too many content within a page - sliced it if have to

### can visual studio code docker extension connect to remote host?

* yes. but prerequisties is need to install Docker in your local machine, and install docker extension (by microsoft)
  * <https://www.axians-infoma.de/techblog/use-vs-code-docker-extension-remote-docker-host/>