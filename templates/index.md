---
layout: default
title: Tech Leadership Templates
---

# 🧩 Tech Leadership Templates

Explore practical templates demonstrating technology leadership, delivery management, and engineering excellence.

---

<ul>
  {% for template in site.templates %}
    <li>
      <a href="{{ template.url }}">{{ template.title | default: template.path | split: '/' | last | replace: '.md', '' }}</a>
    </li>
  {% endfor %}
</ul>
