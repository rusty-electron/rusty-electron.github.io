---
layout: post
title: setting up hibernation in arch linux
tags: linux guide
---

If you have just installed a basic window manager on your arch setup, it is highly likely that hibernation is not set up on your system. I hibernate my system very often and therefore, it is one of the first things that I set up on my system. This is a guide that I have prepared by ~~stealing~~ simplying instructions from this archwiki page.

### set up a swap file (or partition)

I recommend using a swap file. Although there exists much debate about the performance difference of using a swap partition vs. swap file, for a regular user the difference is unnoticeable and one added benefit of using a swapfile is that you can easily move around, delete old swap file and create new ones (with a different size) at ease. If you are looking for instructions to set up hibernation using a swap partition, you can find many guides online.

Here I list instructions to create and setup a swap file:

* Create a swap file 
    Use the `dd` tool for this purpose. (You can use tools like `fallocate` too)

    ```
    sudo dd if=/dev/zero of=/swapfile bs=1M count=16384
    ```

    Here I created a file of size 16GB that I shall use as a swapfile. It is recommended to have a swapfile which is equal (or 1.5 times) in size to your RAM amount. You can also place the swapfile in your home directory. I have mine at `/home/pritom/swapfile`.

* set appropriate permissions

    Swapfile must have specific permissions on or else you can't use it as swap.
    ```bash
    sudo chmod 600 /swapfile
    ```
* enable swapfile (temporary)
    You can enable and start using your newly created swapfile using the following commands:

    ```bash
    # set up the file as swap
    sudo mkswap /swapfile

    # enable file for swapping
    sudo swapon /swapfile
    ``` 

* updating `fstab`
    In order to make sure that the swapfile is enable at reboot, we need to add an entry for it in the `fstab` file

    assuming you already have a working fstab file, add the following line. Also note that if you already have a similar line for swap in the file, remove it.

    ```
    /swapfile 			none		swap      	defaults  	0 0
    ```
    
    * The first field is for the **device**, we add the path to the file here. If you were using a partition then you would add the mount point or the UUID of the device.
    * The second field is **mount point**, it is `none` in our case.
    * The third field is **file system type**, it is `swap`.
    * The fourth field is for **mount options**, we can set it as `defaults`
    * The fifth field is for **backup operation**, leave it as 0 for no backup
    * The sixth field is for **file system check order**, we don't want `fsck` to check it so we leave it as 0.

### gathering UUID and file offset values

You can find the swap device UUID using the command:

```bash
findmnt -no UUID -T /swapfile
```

In order to find the value of `swap_file_offset`, you need to run the following commands on your system.

```bash
filefrag -v /swapfile | awk '$1=="0:" {print substr($4, 1, length($4)-2)}'
```

Or,

you can install the `uswsusp` package and run `swap-offset /swapfile`.

### editing *grub* config file

Edit the file at `/etc/default/grub`, preferably using `sudoedit`

```bash
sudoedit /etc/default/grub
```

Find the line that contains `GRUB_CMDLINE_LINUX_DEFAULT` and add the following options after it:
(or if `GRUB_CMDLINE_LINUX` exists then add the following options to it)

```bash
GRUB_CMDLINE_LINUX="resume=UUID=<swap_device UUID> resume_offset=<swap_file_offset>"
# or you can edit `GRUB_CMDLINE_LINUX_DEFAULT`
```

Then, run `sudo update-grub` to update the grub config file.

### add *resume* option to the list of hooks

Edit the file `/etc/mkinitcpio.conf` and add `resume` to the list of hooks.

```bash
# notice that resume is now added to the list of hooks
HOOKS=(base udev resume autodetect modconf block filesystems keyboard fsck)
```

Create a new image with the new config file by running `sudo mkinitcpio -p`

### reboot your system

After rebooting you can test if your swapfile is working by running `swapon -s`. If you see a line that starts with `/swapfile` then it is working.

Test the hibernation by running `systemctl hibernate`.

If everything went well, your system should hibernate and resume successfully.

### [optional] storing your swapfile in /home

If your swapfile is located in your `/home` directory (like in `/home/pritom/swapfiile`), you may not be able to use it for hibernation unless you make the following changes to turn off sandboxing option for `\home` directory.

    run `systemctl edit systemd-logind` and add the following:
    ```
    [Service]
    ProtectHome=read-only
    ```










