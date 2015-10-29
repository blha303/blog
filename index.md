---
layout: default
---

<div class="posts">
  {% for post in site.posts %}
    <article class="post">

      <h1><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></h1>

      <div class="entry">
        {{ post.excerpt }}
      </div>

      <a href="{{ site.baseurl }}{{ post.url }}" class="read-more">Read More</a>

  <div class="date">
    {% assign year = post.date | date: "%Y" %}
    {% assign month = post.date | date: "%m" %}
    {% assign day = post.date | date: "%d" %}
    Written on
      <a href="/{{ year }}/{{ month }}/">{{ post.date | date: "%B" }}</a>
      <a href="/{{ year }}/{{ month }}/{{ day }}">{{ post.date | date: "%e" }}</a>,
      <a href="/{{ year }}">{{ post.date | date: "%Y" }}</a>
  </div>
    </article>
  {% endfor %}
</div>
