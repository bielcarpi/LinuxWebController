#!/bin/bash
echo -e "Content-type: text/plain\n"
# apache ALL=NOPASSWD: /sbin/useradd, /sbin/userdel, /bin/passwd
IN=$(cat)

if [ -n "$IN" ] #If IN is not empty
then
  action=$(echo "$IN" | cut -d "&" -f1)
  args=$(echo "$IN" | cut -d "&" -f2)

  if [[ $action == "rm" ]]
  then
    #Delete user with name $args
    sudo userdel -r -f "$args"
    [ $? -eq 0 ] && sudo logger -p user.info "User removed with name: $args"
    [ $? != 0 ] && sudo logger -p user.info "Tried but could not remove user with name: $args"
  elif [[ $action == "add" ]]
  then
    #Add user with name, email & password introduced
    user=$(echo "$args" | cut -d "|" -f1)
    pwd=$(echo "$args" | cut -d "|" -f2)

    sudo useradd -m "$user"
    echo -e -n "$pwd\n$pwd\n$pwd" | sudo passwd "$user"
    [ $? -eq 0 ] && sudo logger -p user.info "User added with name: $user"
    [ $? != 0 ] && sudo logger -p user.info "Tried but could not add user with name: $user"
  fi
else
  #Send a list of system users
  sudo logger -p user.info "Users list sent to web"
  tac "/etc/passwd"
fi