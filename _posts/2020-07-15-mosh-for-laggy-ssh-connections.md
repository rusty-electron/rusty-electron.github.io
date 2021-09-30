---
layout: post
title: mosh - for laggy ssh connections
date: Wed, 15 Jul 2020 10:26:53 +0530
category: tools
---

I have bad internet connection at home and I need to frequently connect to a VPS via ssh. When the connection is slow, there is a big lag in between my typing and the keystrokes appearing at the server terminal. This is especially worse when I need to edit files in `vim`. At one point I used WinSCP to edit the files in a GUI where it loads a local copy for editing and then copies the local edits to the server when I save it but I wanted a better solution for this, one where I don't need to leave the CLI. So, [mosh][1]{:target="_blank"} came to the rescue.

Mosh defines itself as "a replacement for interactive SSH terminals. It's more robust and responsive, especially over Wi-Fi, cellular, and long-distance links.", it has made my life much easier and it is easy to catch on too. Another feature that I like is that in case when the internet connection is lost for longer periods, it doesn't disconnect automatically and resumes when the connection is restored.

**Common usage examples:**
```bash
# typical connect
$ mosh &lt;hostname&gt;

# connect through a specific port e.g. 8022
$ mosh --ssh="ssh -p 8022" &lt;hostname&gt;

# using private key
$ mosh --ssh="ssh -i &lt;privatekey-file&gt;" &lt;hostname&gt;
```

Note: mosh must be installed on both server and client side. If using mosh on a VPS, remember to allow connections via any of UDP ports from 60000-61000.

[1]: https://www.mosh.org
