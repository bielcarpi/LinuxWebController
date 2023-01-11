#!/bin/bash
# Whenever a USB is plugged in, the system will automatically mount it (as it's
#  configured with udev). Using udev, we'll run a script whenever this
#  event happens that will search for songs in the mounted USB. These songs will be
#  listed in a file called /srv/www/music-list.txt
# This script will simply return the music-list.txt as text
echo -e "Content-type: text/plain\n"
../get-music.sh
tac "../music-list.txt"
sudo logger -p user.info "Music list sent to web"
