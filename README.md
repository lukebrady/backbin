# ~/backbin
Easily setup Linux to Windows backups using the Common Internet File System.

[![BCH compliance](https://bettercodehub.com/edge/badge/lukebrains/backbin?branch=master)](https://bettercodehub.com/)

# How to use backbin:
1. Create a share on the backup destination.
2. Run the bootstrap_cifs.sh file on the Linux server you will be backing up.
3. Create a credential file that contains username=someuser, password=somepassword, and domain=somedomain. This should be stored at /home/someuser/cred.
4. (Optional) Run backup.sh to create an initial file level and dd backup of the system.
5. Run register_cron.sh to register the cron job so that backups will run every night.

Note: All scripts are configurable and can be changed by editing the values of the variables within each script.
