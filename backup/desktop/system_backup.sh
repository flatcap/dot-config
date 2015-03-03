#!/bin/bash

PATH="/usr/bin:/usr/sbin"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

cd /

DATE=$(date "+%Y_%m_%d")
DIR="/mnt/backup/system/$DATE"

mkdir --parents $DIR

tar --create --file $DIR/cron.tar                       var/spool/cron
tar --create --file $DIR/etc.tar                        etc
tar --create --file $DIR/mysql.tar --exclude mysql.sock var/lib/mysql
tar --create --file $DIR/root.tar                       home/root
tar --create --file $DIR/usr_local.tar                  usr/local
tar --create --file $DIR/var_log.tar                    var/log
tar --create --file $DIR/www.tar                        var/www

cd $DIR

rpm --query --all | sort > rpm_list
rpm --query --all --last > rpm_last

(cd /mnt/tera/tv;     find . -type f) | sort > tv.txt
(cd /mnt/tera/music;  find . -type f) | sort > music.txt
(cd /mnt/images;      find . -type f) | sort > images.txt

mkdir $DIR/fdisk
for disk in sda sdb sdc sdd; do
	fdisk -lu /dev/$disk            > $DIR/fdisk/$disk.txt
	dd if=/dev/$disk bs=512 count=1 > $DIR/fdisk/$disk.bin 2> /dev/null
done
tar --create --file $DIR/fdisk.tar fdisk
rm -fr $DIR/fdisk

find $DIR -name \*.tar -o -name \*.txt | xargs -n1 -P4 -- xz -9

chown flatcap:flatcap -R $DIR
chmod 400 $DIR/*
chmod 500 $DIR

