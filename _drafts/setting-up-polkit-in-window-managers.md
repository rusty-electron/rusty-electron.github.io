---
layout: post
title: making your window manager setup usable
tags: linux guide
---

When you install a window manager for your minimalist arch setup, you miss out (intentionally) on many of the features that are provided at install by desktop environments. If you avoided them intentionally it is fine but if you actually want to have them in your setup, then yes it is quite easy to do. It just requires you to tinker around a little bit. When I first got started using window managers, I missed these features and had to slowly figure out the way to find tools for the task or implement them myself. This post is a guide for setting up these features in a window manager.

The features that I cover are:
* autostarting applications
* adding battery low alerts
* setting up auto-hibernate on low battery
* setting up routine backups
* setting up `polkit` for running gui programs that required elevated privilege
* list of other "useful" programs

## setting up *polkit*

### why install *polkit*

When you try to launch programs like `gparted` or `timeshift` using a launcher or try to mount *ntfs* volumes via your file manager, you will notice that either nothing happens or you will be shown an error prompt about insufficient privileges. This happens because these tasks require higher privilege and as a non-root user you cannot provide these privileges unless you run them as `sudo` (or use policy kit). Note that it is **not** recommended to run gui programs using `sudo`, there is an [archwiki page on this topic][1] which mentions this statement from a GNOME developer:

> "there are no *real*, substantiated, technological reasons why anybody should run a GUI application as root. By running GUI applications as an admin user you are literally running millions of lines of code that have not been audited properly to run under elevated privileges; you are also running code that will touch files inside your $HOME and may change their ownership on the file system; connect, via IPC, to even more running code, etc. You are opening up a massive, gaping security hole [...].

So avoid running gui applications with `sudo` if you can. If one cannot use `sudo` then how do we run these applications (which require elevated privileges)? Although the answer is case specific (read more about it in [this section on archwiki][1]), one solution is to use `polkit`. As explained in archwiki, *[polkit][2] provides an organized way for non-privileged processes to communicate with privileged ones. In contrast to systems such as sudo, it does not grant root permission to an entire process, but rather allows a finer level of control of centralized system policy.*

[1]: https://wiki.archlinux.org/title/Running_GUI_applications_as_root
[2]: https://wiki.archlinux.org/title/Polkit

### how to setup

* First install the `polkit` package
* Although the `polkit` package has a text-based authentication agents, you should also install a graphical one. Choose any one the agents listed in this [page][2]. I have used `polkit-gnome` and it works fine.
* The final step is to make sure that the graphical agent is autostarted on login. In order to setup autostart for this program, you can follow the general steps mentioned in the previous section.

    I just added this line to my `.xprofile` as I am using a display manager
    ```bash
    # i am using gnome-polkit
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
    ```

    The path for all the graphical authentication agents are also listed in this [page][2].
