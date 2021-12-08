#!/bin/sh
service cron start
# Docker Entrypoint, generates logrotate config file, sets up crontab and hand over to `tini`
cat /logrotate.tpl.conf | envsubst > /etc/logrotate.conf

echo "$CRON_SCHEDULE /usr/sbin/logrotate -v /etc/logrotate.conf > /var/log/logrotate.log 2>&1" | crontab -

touch /var/log/logrotate.log
tail -f /var/log/logrotate.log
