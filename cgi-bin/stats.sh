#!/bin/bash
# Echoes stats for the system
echo -e "Content-type: text/plain\n"
awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) ; }' \
<(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat) #print CPU usage (in %)
free -m | awk 'NR==2{printf "%.2f\n", $3*100/$2 }' #print RAM usage (in %)
grep -c ^processor /proc/cpuinfo #print num of cores
free -m | awk 'NR==2{printf "%.2f\n", $2/1000 }' #print GBs of RAM in the System
df -h | awk '$NF=="/"{printf "%d\n", $3}' #print disk used (in GB)
df -h | awk '$NF=="/"{printf "%d\n", $2}' #print disk in the System (in GB)
uptime -p | awk -F " " '{printf "%dh %dm\n", $2, $4}' #print uptime
last -n 10 | tr -s ' ' #print last 10 logins