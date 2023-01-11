#!/bin/bash
# This script will be executed with udev, whenever some USB is plugged in.
# It will update the file /srv/www/music-list.txt with the songs that are inside the
#  mounted USB.
# Add this line in /etc/udev/rules.d/85-usb-drive.rules to run the script whenever this happens
#  SUBSYSTEM=="block", #KERNEL=="sd*", #ENV{ID_FS_TYPE}=="vfat", #ENV{ID_BUS}=="usb", #SYMLINK+="usb_drive", #RUN+="/bin/mount /dev/usb_drive /mnt/usb -o rw,user", #RUN+="/srv/www/get-music.sh"
ls /mnt/usb/*.{mp3,wav,aac} > /srv/www/music-list.txt
