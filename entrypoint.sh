#!/bin/sh
service cron start
# Docker Entrypoint, generates logrotate config file, sets up crontab and hand over to `tini`
gomplate < logrotate.tpl.conf > /etc/logrotate.conf
# grab host envars
export >> /etc/profile.d/env.sh 
echo "$CRON_SCHEDULE /bin/bash -l -c '/usr/sbin/logrotate -v /etc/logrotate.conf > /var/log/logrotate.log 2>&1'" | crontab -

touch /var/log/logrotate.log
tail -f /var/log/logrotate.log
