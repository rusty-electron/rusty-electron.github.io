---
layout: default
title: rustyelectron's blog
---

## Hi, I am Pritom.
I like to create stuff using programming and electronics.

### interests:
* deep learning
* embedded systems
* control systems

while you are here you can checkout my useful programs list [WIP]\\
 or [my reading list][1]{: class="noline"}

## recent posts:

<ul>
{% for post in site.posts limit:5 %}
	<li><a class="noline" href="{{ post.url }}">{{ post.title | downcase }}</a></li>
{% endfor %}
<a class="noline" href="/blog">see more..</a>
</ul>

[1]: /books
