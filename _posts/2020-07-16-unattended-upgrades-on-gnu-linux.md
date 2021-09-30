---
layout: post
title: unattended upgrades on gnu/linux
date: Thu, 16 Jul 2020 16:18:21 +0530
category: linux
---

I run this site on a VPS and as for vpn I use OpenVPN that passes my traffic through a VPS. I am too lazy to periodically access one of these servers and manually run `sudo apt update && sudo apt upgrade`. I found these commands and config files that will periodically update the system and also reboot at a specific time if required for important kernel updates.

```bash
# install unattended-upgrades package along with some utilities
$ sudo apt install unattended-upgrades apt-listchanges bsd-mailx

# enable security updates
$ sudo dpkg-reconfigure -plow unattended-upgrades
```

Edit the `/etc/apt/apt.conf.d/50unattended-upgrades` file and add/modify the following lines:

```bash
Unattended-Upgrade::Mail "yourmail@here.com" # for update notifications

Unattended-Upgrade::Automatic-Reboot "true";  # setup up automatic reboot
Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";
Unattended-Upgrade::Remove-Unused-Dependencies "true";
Unattended-Upgrade::Automatic-Reboot-Time "05:00"; # specify reboot time
```

 You can test if it works by running `sudo unattended-upgrades --dry-run`.
