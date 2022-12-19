#!/bin/bash
echo -e "Content-type: text/plain\n"
IN=$(cat)

if [ -n "$IN" ] #If IN is not empty
then
  #Add new programmed task
  (echo "$IN" | cut -d "&" -f1) >> /etc/

  #Delete existing programmed task
else
  sudo fcrontab -l #Shows all the scheduled tasks by cron
fi
