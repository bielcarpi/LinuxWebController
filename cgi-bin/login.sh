#!/bin/bash
# Check whether a login for the system is correct.
# If not, send an error message.
echo -e "Content-type: text/plain\n"
IN=$(cat)
username=$(echo "$IN" | cut -d "&" -f1)
pwd=$(echo "$IN" | cut -d "&" -f2)

if [ "$(getent passwd "$username")" ]
then
    pwdEncrypted=$(grep -w "root" /etc/shadow | cut -d ":" -f2) #user info in /etc/shadow (apache user needs to have read permission)
    algorithm=$(echo "$pwdEncrypted" | cut -d "$" -f2) #algorithm
    salt=$(echo "$pwdEncrypted" | cut -d "$" -f3) #salt
    export algorithm
    export salt
    export pwd
    newPwdEncrypted=$(perl -le 'print crypt("$ENV{pwd}","\$$ENV{algorithm}\$$ENV{salt}\$")')
    if [ "$pwdEncrypted" == "$newPwdEncrypted" ]
    then
      sudo logger -p user.info "User $username has logged into the system"
      echo "/dashboard.html"
    else
      sudo logger -p user.info "User $username has introduced an incorrect password to access the system"
      echo "Error. The password for $username is incorrect."
    fi
else
    sudo logger -p user.info "Attempt to enter the system with username: $username"
    echo "Error. The user $username doesn't exist."
fi