#!/bin/bash
echo -e "Content-type: text/html\n"
info=$1
arr=${$info// / }

echo -e "$1\n"
username=${arr[0]}
echo "username: $username"
echo ${su -c $username whoami}

