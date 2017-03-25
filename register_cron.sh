#!/bin/bash
# This value will need to be changed.
$SCRIPT_DIR=/home/luke/backup.sh

# Echo cronjob and redirect output
# to /etc/crontab
echo "0 12 * * * root bash ${SCRIPT_DIR}" >> /etc/crontab