#!/bin/bash
# Show, add, modify filtering rules from iptables
# apache ALL=NOPASSWD: /bin/iptables
# /run/xtables.lock must have read permission
echo -e "Content-type: text/plain\n"
IN=$(cat)

if [ -n "$IN" ] #If IN is not empty
then
  action=$(echo "$IN" | cut -d "&" -f1)
  args=$(echo "$IN" | cut -d "&" -f2)

  if [[ $action == "add" ]]
  then
    #Add new iptables rule
    sudo logger -p user.info "New iptables rule added: $args"
    sudo iptables -A $args
  elif [[ $action == "rm" ]]
  then
    #Delete existing iptables rule
    sudo logger -p user.info "Existing iptables rule deleted: $args"
    sudo iptables -D $args
  fi
else
  sudo logger -p user.info "Package filtering sent to web"
  sudo iptables -S | grep "\-A" #Show the ip rules
fi
