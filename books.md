---
layout: default
title: books
---

### books i am reading rn

<div class="book-container">
    {% for book in site.data.books %}
        {% if book.tag == "active" %}
            <div class="book-item">
            <img src="assets/images/{{ book.img }}" width="200px">
            <p class="right">{{ book.name }}</p>
            </div>
        {% endif %}
	{% endfor %}
</div>

### books read

\* will add later *

### books abandoned (temporarily 🥲)

<div class="book-container">
    {% for book in site.data.books %}
        {% if book.tag == "ab" %}
            <div class="book-item">
            <img src="assets/images/{{ book.img }}" width="200px">
            <p class="right">{{ book.name }}</p>
            </div>
        {% endif %}
	{% endfor %}
</div>

<div class="right">
    <a class="noline" href="https://github.com/rusty-electron/get-book-cover" target="_blank">script to download book covers</a>
</div>
