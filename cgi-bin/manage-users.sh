#!/bin/bash
echo -e "Content-type: text/plain\n"
IN=$(cat)

if [ -n "$IN" ] #If IN is not empty
then
  #Delete user with name $IN
  echo ""
else
  #Send a list of system users
  tac "/etc/passwd"
fi
