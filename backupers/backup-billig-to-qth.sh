#!/bin/sh


/usr/bin/rsync -avPH --delete --numeric-ids --exclude=/proc/* --exclude=/dev/* --exclude=/sys/* --exclude=/tmp/* --exclude=/mnt/datas --exclude=/mnt/datas2/ / root@10.9.100.201:/var/backup-billig/
