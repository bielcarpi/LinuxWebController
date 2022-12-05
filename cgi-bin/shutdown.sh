#!/bin/bash
# Reboot or shutdown the system
# To perform this actions, user must have privileges, so the sudoers file has been modified adding this line:
# apache ALL=NOPASSWD: /sbin/reboot, /sbin/poweroff
echo -e "Content-type: text/plain\n"
IN=$(cat)

if [ "$IN" == "shutdown" ]
then
  sudo poweroff
elif [ "$IN" == "restart" ]
then
  sudo reboot
fi





