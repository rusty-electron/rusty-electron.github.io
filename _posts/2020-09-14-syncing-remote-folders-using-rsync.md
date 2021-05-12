---
layout: post
title: syncing remote folders using rsync
date: Mon, 14 Sep 2020 03:34:18 +0530
---
I used to manage this blog by logging in to the VPS and then running the `lb` script to make new posts and edit or delete old ones. It kind of got tedious and I was always thinking of switching to using rsync to synchronize remote folders like this blog folder. I finally got around, installed rsync and looked up the man page. I needed a way to use the private key for the remote login so I found this useful command that downloads the remote folder to my local machine:

```bash
$ rsync -e 'ssh -i ~/path/to/privatekey.pem' -avz user@hostname:/remote/directory/ ~/local/directory/
```

Once the remote folder is downloaded on my local machine, I make changes to the local copy of the blog and then upload the changes to the remote server using the command:

```bash
$ rsync -e 'ssh -i ~/path/to/privatekey.pem' -avz ~/local/directory/ user@hostname:/remote/directory/
```

Apart from being convenient, It is also efficient as when synchronization occurs, rsync makes use of its delta-transfer algorithm that transmits only the changes made to the source files and thus, reduces the amount of data sent. Also, these commands are very long and I cannot imagine myself typing these commands again and again so I suggest using shell aliases.
