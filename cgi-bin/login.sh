#!/bin/bash
echo -e "Content-type: text/plain\n"
IN=$(cat)
echo "$IN"
username=$(echo "$IN" | cut -d "&" -f1)
pwd=$(echo "$IN" | cut -d "&" -f2)
echo "username sent: $username"
echo "pwd sent: $pwd"

if [ "$(getent passwd "$username")" ]
then
    echo "The user exists."
    pwdEncrypted=$(sudo grep -w pwd /etc/shadow | cut -d ":" -f2) #user info in /etc/shadow
    echo "$pwdEncrypted"
    algorithm=$(echo "$pwdEncrypted" | cut -d "$" -f2) #algorithm
    salt=$(echo "$pwdEncrypted" | cut -d "$" -f3) #salt
    export algorithm
    export salt
else
    echo "The user $username doesn't exist."
fi




