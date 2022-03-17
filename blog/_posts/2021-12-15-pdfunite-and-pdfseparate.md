---
layout: post
title: cli pdf utilities
date: 2021-12-15 17:19 +0530
tags: linux
---

There have been multiple instances where I search for cli pdf utilies and always end up in stackoverflow searching for a tool that has minimal dependencies and with the required set of options. I usually end up using the utilies `pdfunite` and `pdfseparate` found in the `poppler` (arch) or `poppler-utils` (debian/ubuntu based) package. I occasionally find myself using `qpdf` or `gs` too. (will update)

### combining pdfs

`pdfunite` commands comes to the rescue:

```sh
pdfunite PDF-sourcefile1..PDF-sourcefilen PDF-destfile
```

example (from the `man` page):
```sh
# merges all pages from sample1.pdf and sample2.pdf (in that order) and creates sample.pdf
pdfunite sample1.pdf sample2.pdf sample.pdf
```

### extracting individual pages

In many cases when you are submitting documents to a website, you scan the hardcopies all at once and end up with a single pdf. If now the website requires you to submit them separately (which is usually the case), you can use `pdfseparate`.

* If you need all of the pages in the document as separate pdfs:
```sh
pdfseparate sample.pdf sample-%d.pdf
```
This extracts all pages from `sample.pdf`, i.e. if `sample.pdf` has 3 pages, it produces `sample-1.pdf`, `sample-2.pdf`, `sample-3.pdf`

* If you only wish to specify the page ranges to extract:
```sh
pdfseparate -f 3 -l 5 <source_pdf_file> <name>-%d.pdf
```
You can specify the first and last pages using `-f` and `-l` resp. If the source pdf file has 10 pages, this command will extract the individual pages from page 3 to page 5 as separate pdfs. 

> I will be updating this post to add more tools eventually