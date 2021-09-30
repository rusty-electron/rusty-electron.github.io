---
layout: post
title: web-scraping form field labels
date: Fri, 10 Jul 2020 00:24:49 +0530
category: python
---

My cousin asked me to help with the documents required for a college form website so I checked the site but was too lazy to write it all down. I quickly wrote the following python script, grabbed the form labels and sent him the list. I think this could serve as a good boilerplate code.

```python
from bs4 import BeautifulSoup
import requests

link = "[insert form link here]"
res = requests.get(link)
foundFile = res.text.encode('utf-8')

soup = BeautifulSoup(foundFile, 'html.parser')
foundDivs = soup.find_all("div", class_="label_title")

for div in foundDivs:
	textContent = div.text
	if len(textContent) > 0:
		textContent = textContent.replace('*','')
		print(textContent)
```
