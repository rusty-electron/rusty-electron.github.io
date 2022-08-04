---
layout: post
title: setting up cloud folder sync with rclone
tags: linux guide
---

Having some (or all of) your files synced with a cloud service provider is a good call. It is helpful to have backup in this form and it makes the files accessible from any device (provided you have an internet connection). But most cloud providers provide client programs only for Windows or Mac. As of 2022, only Dropbox provides an official client for Linux. But sadly, their free plan only provides 5 GB of storage. I, being broke, prefer to have the 15 GB of free storage provided by Google drive. It is enough to have my most important files backed up. So I started looking up hacky ways to set up a system that syncs my files with Google drive. 

After testing different methods, I finally settled on this method that uses [`rclone`](https://rclone.org/) for mounting cloud storage. `rclone` works with almost all cloud providers and all their plans (both free and premium) so you should have no issues with it.

### setting up rclone

* install `rclone` using your package manager

    ```bash
    # for arch linux
    sudo pacman -S rclone
    ```

* to make your life easier, also install [`rclone-browser`](https://kapitainsky.github.io/RcloneBrowser/)

    ```bash
    # for arch linux and yay users
    yay -S rclone-browser
    ```

### configure rclone

Open a terminal and run the following command:

```bash
rclone config
```

From this point, based on what cloud storage provider you are using, you should follow the steps listed in the [rclone documentation][1].

[1]: https://rclone.org/docs/#configure

Just choose your provider from the list and follow the steps in the **configure** section. If you find it difficult, you can also look up other guides and videos online that explain how to configure rclone (with your provider).

Once, you have configured rclone, launch `rclone-browser` and you should see the cloud storage provider(s) that you have added.

### mount cloud storage

#### using rclone-browser

* create an empty folder in your home directory

    This is the folder where your cloud drive will be mounted.

* In `rclone-browser`, double-click on your cloud drive and select `Mount`

    You will be asked to choose a mount point. Choose the empty folder you created in the previous step.

    If it is successful, you should see the cloud drive mounted in the folder you chose. You can visit the folder using your file manager and verify the contents.

#### using cli

You can also use the cli to mount the cloud drive.

```bash
rclone mount <remote>:/ <local_mount_point> &
# add & to run in background
```

You can get the list of remotes using the command, `rclone listremotes`.

To unmount the cloud drive.

```bash
fusermount -uz <local_mount_point>
```

### syncing files

You can choose between two types of sync:
* **unidirectional sync:**
    * **local-to-cloud:** Files are synced from your local machine to the cloud drive. Files in the cloud that are not present locally are deleted. The use case is for when you need to keep a copy of your local files on the cloud.
    * **cloud-to-local:** Files are synced from the cloud drive to your local machine. Files in the local machine that are not present in the cloud are deleted. The use case is for when you need to download files from the cloud and not make any changes to it from your end.
* **bidirectional sync:** Files are synced from the local machine to the cloud drive and vice versa. The changes are propagated in both directions.

#### unidirectional sync

For unidirectional sync, I found that [`rsync`](https://linux.die.net/man/1/rsync) is the best tool. 

```bash
sudo pacman -S rsync
```

Assume that your drive is mounted at `/home/user/cloud_mnt` and you need to sync the folders:
```
/home/user/folder1
/home/user/folder2/documents
```

You can create a bash script with the commands:

```bash
#!/bin/sh
rsync -av --delete /home/user/folder1/ /home/user/cloud_mnt/folder1
rsync -av --delete /home/user/folder2/documents/ /home/user/cloud_mnt/documents
# note: the trailing slash at the end of the source folder is important 
```

This is for unidirectional sync from local to cloud. If you wish to sync periodically, you can use cron jobs.

#### bidirectional sync

Here we will use [`osync.sh`](http://www.netpower.fr/osync). It is available in the AUR as `osync`.

```bash
yay -S osync
```

We will use the examples of the same folders here.

```bash
#!/bin/sh
osync.sh --initiator=/home/user/folder1 --target=/home/user/cloud_mnt/folder1
osync.sh --initiator=/home/user/folder2/documents --target=/home/user/cloud_mnt/documents
```

As mentioned before, you can use cron jobs for periodic sync.

> **Note:** you should not use `rsync` and `osync.sh` for the same folder. `osync.sh` creates some hidden files for its working so if you use `rsync` on the same directory. It will sync these hidden files to the destination as well and cause problems when you run `osync.sh` the next time.

### example script

Here is a example script that you can use/extend after adding your own paths:

```bash
#!/bin/sh

MNT_PT=/home/$USER/drive_mnt
MNT_NAME="gdrive"

function sync_files() {
    # one way sync
    rsync -av --delete /home/$USER/myfiles/folder1/ $MNT_PT/folder1
    # add more commands here

    # unmount rclone drive
    fusermount -uz $MNT_PT
}

# mount rclone drive
rclone mount "$MNT_NAME":/ $MNT_PT &

# check if mounted successfully using rclone
# wait in while loop and sleep 1
# until mount is successful
# check if mount is successful by grepping `mount` for $MNT_NAME
# if successful, run sync_files
while true; do
    if grep -q $MNT_NAME /proc/mounts; then
        echo "Mounted successfully"
        sync_files
        break
    fi
    sleep 1
    echo "waiting for mount..."
done
```

### experience with other alternatives

* [unison](https://www.cis.upenn.edu/~bcpierce/unison/)

    I tried out `unison` first for bidirectional sync but gave up as file permission issues appeared when I tried to sync it with the cloud drive. You can choose to ignore the permission issues and sync the files anyway by specifying options in the config file, see this [answer on SO](https://superuser.com/questions/1166185/making-unison-ignore-file-property-differences). Later, I found `osync.sh` which turned out to be a better tool.

* [freefilesync](https://freefilesync.org/)

    It is a gui tool for bidirectional sync and it is available in the AUR as `freefilesync` and `freefilesync-bin`. I avoided it as it has a lot of dependencies and the source package took very long to compile. 

