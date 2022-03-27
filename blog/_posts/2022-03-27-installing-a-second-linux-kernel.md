---
layout: post
title: installing a second linux kernel
tags: linux
date: 2022-03-27 19:14 +0530
---
This week, a friend of mine complained that her linux install was freezing at random times and the only way to fix it was to restart the computer. I have had this issue previously and I wasn't able to fix it even after reading through several pages of `journalctl` (probably because I am dumb **T-T**). Eventually, this issue was fixed when I installed a new kernel so it was probably a bug with the linux kernel, or drivers interfering with the kernel. In such situations downgrading to a previous kernel can be messy so I usually keep a second kernel installed (usually the `lts` kernel) as a fallback.

<!-- TODO: add a line here -->

Here is a short guide on setting up a second kernel in your archlinux install (`lts` in this case):

1. Install the second kernel of your choice

    You can choose from:
    * `linux` - latest stable
    * `linux-lts` - long term support kernel, best option for stability and old hardware support
    * `linux-hardened` - if you are *very* concerned with security of your system, also note that some program will not work on this kernel
    * `linux-zen` - tweaked for performance

    I will be installing the `linux-lts` kernel:
    ```
    sudo pacman -S linux-lts
    ```
2. Customize grub menu

    After installing the kernel, our next task is to update the grub menu so that we can choose to run a different kernel on startup but before doing that we can customize the way the menu is organized (I do not prefer the default options).

    * Edit `/etc/default/grub`. Note that you need `sudo` privilege to do so.
    
        First disable the submenu, for most setups it is better to be able to see the kernel options all at once. Modify this line to:
        ```
        GRUB_DISABLE_SUBMENU=y
        ```

        Next, in the situation that you started to use the `linux-lts` kernel in order to avoid bugs (as mentioned before) introduced in the `linux-zen` (assume), you would prefer to continue to run the `lts` kernel until a new kernel update arrives for the `linux-zen` kernel. Hence, it is preferred that the grub menu remembers your previous choice.

        Add these new lines for this feature:
        ```
        GRUB_DEFAULT=saved
        GRUB_SAVEDEFAULT=true
        ```
    * Save this file and exit the editor.

3. generate a new grub config file

    We now have to generate a new grub config file to add an entry for the new kernel and also to take into account our new grub options.

    ```
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    ```

On rebooting the system, we should now see a new entry on the grub menu.



