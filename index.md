---
title: {{site.title}}
permalink: /
layout: splash

header:
  overlay_color: "#000"
  overlay_filter: "0.5"
  overlay_image: https://i.redd.it/01sk42ne9rk61.jpg

feature_row1:
  - image_path: /assets/images/unsplash-gallery-image-2-th.jpg
    alt: "placeholder image 2"
    title: "Placeholder Image Left Aligned"
    excerpt: 'This is some sample content that goes here with **Markdown** formatting. Left aligned with `type="left"`'
    url: "#test-link"
    btn_label: "Read More"
    btn_class: "btn--primary"

feature_row2:
  - image_path: /assets/images/unsplash-gallery-image-2-th.jpg
    alt: "placeholder image 2"
    title: "Placeholder Image Right Aligned"
    excerpt: 'This is some sample content that goes here with **Markdown** formatting. Right aligned with `type="right"`'
    url: "#test-link"
    btn_label: "Read More"
    btn_class: "btn--primary"

feature_row3:
  - image_path: /assets/images/unsplash-gallery-image-2-th.jpg
    alt: "placeholder image 2"
    title: "Placeholder Image Center Aligned"
    excerpt: 'This is some sample content that goes here with **Markdown** formatting. Centered with `type="center"`'
    url: "#test-link"
    btn_label: "Read More"
    btn_class: "btn--primary"      
---

## {{site.title}}

* portal configuration

|key|value|
|site.email|{{site.email}}|
|site.description|{{site.description}}|
|site.theme|{{site.theme}}|
|site.minimal_mistakes_skin|{{site.minimal_mistakes_skin}}|
|site.plantuml.url|{{site.plantuml.url}}|
|site.plantuml.type|site.plantuml.type|
|site.search|{{site.search}}|

{% include feature_row %}
