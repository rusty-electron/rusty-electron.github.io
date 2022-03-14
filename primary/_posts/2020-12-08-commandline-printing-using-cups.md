---
layout: post
title:  "commandline printing using cups"
date: Tue, 08 Dec 2020 21:36:30 +0530
tags: linux
---

I wanted to set up printing with my HP Laserjet printer on my thinkpad, I have previously setup printing with this device on ElementaryOS so I know it works seamlessly with HPLIP. Now I wanted to replicate the same on my new machine. I looked up articles on printing on the archwiki and found something about CUPS. I started reading but due to my social media induced short attention-span, couldn't read more than five lines, promised to read later and proceeded to install the package using `pacman`.

I decided to ignore the gui tools and to my surprise, the web interface for CUPS is more than enough. It makes it easy to find, add and manage printer and its configurations like color settings, default paper size, margins, etc. The important part of setting up a new printer is choosing a `.ppd` file, CUPS comes packaged with a lot of `.ppd` files for working with generic printers. It did not have the file for my printer though so after reading the troubleshooting section I came to know that I needed to install the `hplip` package from the AUR. Once I did that, the printer began to accept printjobs from my laptop. Neat!

For printing, open a file, if it has a full-fledged GUI click on the 'print' option or else ubiquitous shortcuts like 'Ctrl+P' work even on minimalist programs like 'zathura'. The print dialog box in linux has most of the required options. For my config, the 'preview' button probably wasn't set up and it printed the file instead. *TODO: find a fix for it*

CUPS is well-suited for commandline printing. The command given below should fulfill most of your needs. If it doesn't, I'll try to add more commands for common use-cases. *TODO: add more commands*

```bash
$ lp -d printername -o landscape -o fit-to-page -o media=A4 filename
```