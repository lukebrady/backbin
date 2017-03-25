#!/bin/bash
NAME=$(uname -n)
NETMOUNT=/dev/backup_share

# Check to see if the user running
# the script is root. Exit 1 if failed.
if [ $(whoami) != "root" ]; then
    echo "You must be root to install cifs-utils."
    exit 1
fi

# Checks to see which Linux Distrobution
# you are currently running and then uses 
# the proper package manager.
cat /proc/version | grep "Red Hat"
if [ $? == 0 ]; then
    echo "Updating Red Hat system ${Name}."
    yum update -y
    echo "Installing cifs-utils on ${NAME}."
    yum install -y cifs-utils
    if [ $? != 0 ]; then
        echo "The install did not complete. Exiting..."
        exit 1
    fi
    echo "Install completed on ${NAME}."
fi

# Installs the simple mail mailx
# service so that notifications
# about backups can be sent about
# if errors occur.
# if [ $? == 0 ]; then
#    yum install mailx
#    if [ $? != 0 ]; then
#         echo "The install did not complete. Exiting..."
#         exit 1
#     fi
#     echo "Install completed on ${NAME}."
# fi

# Check to see if the netmount exists.
# If not, create the netmount and move
# on to the next step.
if [ ! -d $NETMOUNT ]; then
    echo "Making ${NETMOUNT}."
    mkdir $NETMOUNT
fi

echo "${NETMOUNT} already exists. Exiting..."
exit 0