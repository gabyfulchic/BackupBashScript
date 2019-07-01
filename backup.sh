#!/bin/bash

#      Made By FULCHIC Gaby       #
#          To Practice            #

# Backup Location

backupPlace="/srv/backup"
sudo mkdir -p $backupPlace

create_backupfile () {

  tar -czvf "$backupPlace/sharemybox01_$(date +%Y-%m-%d).tar.gz" \
  	/etc/apache2/ \
  	/etc/php/ \
  	/home/ \
  	/etc/mysql/ \
  	/etc/freerad/ \
  	/etc/hosts \
  	/etc/hostname \
  	/etc/resolv.conf \
}

if [ $? == 1 ]
then
    rm -rf $backupPlace
    sudo mkdir -p $backupPlace
fi

numberOfFiles="$(ls -1 | wc -l)"

if [ $numberOfFiles -ge "4" ]
then
    rm "$(ls -t | tail -1)"
    create_backupfile
elif [ $numberOfFiles -lt "4" ]
then
    create_backupfile
fi

# For futures features
# BDD Backups
