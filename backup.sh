#!/bin/bash

#      Made By FULCHIC Gaby       #
#          To Practice            #

# Backup Location

backupPlace="/srv/backup/general"
sqlDumpPlace="/srv/backup/sql"

sudo mkdir -p $backupPlace

if [ $? == 1 ]
then
    rm -rf $backupPlace
    sudo mkdir -p $backupPlace
fi

sudo mkdir -p $sqlDumpPlace

if [ $? == 1 ]
then
    rm -rf $sqlDumpPlace
    sudo mkdir -p $sqlDumpPlace
fi

## FUTURE FEATURE
## BDD Backups
## Add the path to the tar -czvf
# DBUser="root"
# DBPasswd="root"
# DBBase="database"
# mysqldump -u $DBUser -p$DBPasswd $DBBase > "$sqlDumpPlace/sqlBackup.sql"

create_backupfile () {
  tar -czvf "$backupPlace/sharemybox01_$(date +%Y-%m-%d).tar.gz" \
  	/etc/apache2/ \
  	/etc/php/ \
  	/home/ \
  	/etc/freerad/ \
  	/etc/hosts \
  	/etc/hostname \
  	/etc/resolv.conf
#   /srv/backup/sql/ \
}

numberOfFiles="$(ls -1 | wc -l)"

if [ $numberOfFiles -ge "4" ]
then
    rm "$(ls -t | tail -1)"
    create_backupfile
elif [ $numberOfFiles -lt "4" ]
then
    create_backupfile
fi
