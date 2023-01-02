#!/bin/bash
# Echoes logs of Apache
# Syslog must be configured adding this line on /etc/syslog.conf
#   user.info -/srv/www/actions.log
# Sudoers file must have the line:
#   apache ALL=NOPASSWD: /bin/logger
echo -e "Content-type: text/plain\n"
tac "../actions.log"
sudo logger -p user.info "Logs sent to web"
