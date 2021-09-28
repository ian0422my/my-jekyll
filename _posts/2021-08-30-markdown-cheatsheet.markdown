---
layout: single
title:  "Markdown"
date:   2021-08-30 12:07:50 +0800
categories: markdown update
toc: true
toc_label: "In this page"
toc_icon: "cog"
toc_sticky: true
sidebar:
  nav: "about"
---
## markdown cheatsheat

[https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheethttps://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)

### bold

```markdown
***bold***
```

***bold***

### url

```markdown
<url>
```

or

```markdown
[name](url)
```

### image

```txt
![netlify download site](/assets/images/netlify-download-site.png)
```

![netlify download site](/assets/images/netlify-download-site.png)

### table

* use "|" as delimeter
* use ":--" as table row seaparater
* if using visual studio code, we an use plugin "markdown all in one" to format
* use \<br\/\> as carriage return

change from

```markdown
|header1|header2|header3|
|:---|:---|:---|
|short|mediummedium|longlonglong|
```

to (select table > SHIFT+ALT+F)

```markdown
| header1 | header2      | header3      |
| :------ | :----------- | :----------- |
| hort    | mediummedium | longlonglong |
```

| header1 | header2      | header3      |
| :------ | :----------- | :----------- |
| hort    | mediummedium | longlonglong |
