---
layout: post
title: keep ssh connection alive
date: Thu, 09 Jul 2020 22:54:46 +0530
---

It is very annoying when I look up something in a different window and then switch back to the ssh terminal only to find out that the connection has timed out and I need to log in again.
One way to solve this is to send null packets at regular intervals from the client side. Open the `~/.ssh/config` file and add the following lines:

```
Host example
    Hostname example.com
    Port 22
    User username
    ServerAliveInterval 240
    ServerAliveCountMax 2
```

Replace `example` with a label for the connection, `example.com` with the hostname and `username` with the remote username. `ServerAliveInterval` value of 240 means that it will send null packets every 240 seconds to keep the connection alive. According to `ServerAliveCountMax`, the ssh client will close the connection if it does not receive a response after two tries. rtfm `man ssh_config`.
