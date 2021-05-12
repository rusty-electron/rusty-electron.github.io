---
layout: default
title: books
---

### books i am reading rn

<div class="book-container">
    {% for book in site.data.books %}
    <div class="book-item">
     <img src="assets/images/{{ book.img }}" width="200px">
     <p class="right">{{ book.name }}</p>
     </div>
	{% endfor %}
</div>

### books read

\* will add later *
