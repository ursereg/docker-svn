#!/bin/bash

# Start CRON
service cron start

# Apache can be sensitive to leftover pid file
rm /var/run/apache2.pid

# Start apache
/usr/sbin/apache2 -DFOREGROUND
