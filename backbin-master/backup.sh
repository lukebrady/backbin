#!/bin/bash
DATE=$(date +%m_%d_%y)
IMG_DATE=$(date +%m_%d_%y)_img
# The values below will need to be
# changed.
NETMOUNT=/dev/backup_share
IMG_FILE="splunk.img"
RMFS=//192.168.1.240/Share
USER=luke
CRED_FILE=/home/luke/cred

# Check to see if the user running
# the script is root. Exit 1 if failed.
if [ $(whoami) != "root" ]; then
    echo "You must be root to install cifs-utils."
    exit 1
fi
# Check to see if the netmount exists.
# If not, create the netmount and move
# on to the next step.
if [ ! -d $NETMOUNT ]; then
    echo "Making ${NETMOUNT}."
    mkdir $NETMOUNT
fi
echo "${NETMOUNT} already exists. Moving on..."

# Now we mount the network file share to 
# the mount location in the /dev/ directory.
# This will be the path where all files will
# be sent across the network.
mount.cifs $RMFS $NETMOUNT -o credentials=${CRED_FILE}
if [ $? != 0 ]; then
    echo "Mount to ${RMFS} failed."
    exit 1
fi
echo "Mount to ${RMFS} successfully completed."
rsync -avzh / --exclude $NETMOUNT ${NETMOUNT}/${DATE}
if [ $? != 0 ]; then
   echo "File level backup failed."
fi

# Runs a bare metal backup or dd backup
# and sends the image to the netmount
# location.
if [ ! -d ${NETMOUNT}/${IMG_DATE} ]; then
    echo "Making ${NETMOUNT}/${IMG_DATE}."
    mkdir ${NETMOUNT}/${IMG_DATE}
fi
dd if=/dev/sda of=${NETMOUNT}/${IMG_DATE}/${IMG_FILE}
if [ $? != 0 ]; then
    echo "Bare metal backup failed."
    exit 1
fi

# Unmount the network file share.
umount /dev/backup_share/
exit 0