#!/bin/bash
# Show, add, delete cron jobs
# To perform this actions, user must have privileges, so the sudoers file has been modified adding this line:
# apache ALL=NOPASSWD: /sbin/fcrontab, /bin/sed
# File /etc/fcron/fcron-apache.conf should exist, with owner apache, group fcron & permissons 644
echo -e "Content-type: text/plain\n"
IN=$(cat)

if [ -n "$IN" ] #If IN is not empty
then
  action=$(echo "$IN" | cut -d "&" -f1)
  args=$(echo "$IN" | cut -d "&" -f2)

  if [[ $action == "add" ]]
  then
    #Add new programmed task
    echo "$args" >> /etc/fcron/fcron-apache.conf
    sudo fcrontab -n /etc/fcron/fcron-apache.conf -u apache
  elif [[ $action == "rm" ]]
  then
    #Delete existing programmed task
    sudo sed -i "$args d" /etc/fcron/fcron-apache.conf
    sudo fcrontab -n /etc/fcron/fcron-apache.conf -u apache
  fi
else
  sudo fcrontab -l -u apache #Shows all the scheduled tasks from user apache
fi
