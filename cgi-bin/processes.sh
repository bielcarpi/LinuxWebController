#!/bin/bash
# Echoes processes of the system if there is nothing in POST body.
# If there is a valid PID and Seconds in POST body, stops that process for X seconds
#  and returns nothing.
# The kill command must be run with sudo, so we need privileges. Modify the sudoers file to add this line:
# apache ALL=NOPASSWD: /bin/kill
echo -e "Content-type: text/plain\n"
IN=$(cat)

if [ -n "$IN" ] #If IN is not empty
then
  pid=$(echo "$IN" | cut -d "&" -f1)
  seconds=$(echo "$IN" | cut -d "&" -f2)
  if [[ $seconds == "kill" ]]
  then
    sudo kill "$pid" #Send a SIGTERM to process
  else
    sudo kill -STOP "$pid" #Send a SIGSTOP to process to pause it
    sleep "$seconds"
    sudo kill -CONT "$pid" #After X seconds, send a SIGCONT to process to resume it
  fi
else
  ps aux | tr -s ' ' | tac #Output all processes, separating fields with only a ' '
fi