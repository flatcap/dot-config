#!/bin/bash

PATH="/usr/bin:/usr/sbin"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

DATE=$(date "+%Y_%m_%d")
DIR="/mnt/backup/system/$DATE"

cd /

mkdir -p $DIR

tar cf $DIR/cron.tar                       var/spool/cron
tar cf $DIR/etc.tar                        etc
tar cf $DIR/mysql.tar --exclude mysql.sock var/lib/mysql
tar cf $DIR/root.tar                       home/root
tar cf $DIR/usr_local.tar                  usr/local
tar cf $DIR/var_log.tar                    var/log
tar cf $DIR/www.tar                        var/www

cd $DIR

rpm -qa | sort > rpm_list
rpm -qa --last > rpm_last

(cd /mnt/tera/tv;     find . -type f) | sort > tv.txt
(cd /mnt/tera/music;  find . -type f) | sort > music.txt
(cd /mnt/images;      find . -type f) | sort > images.txt

mkdir fdisk
#for disk in sda sdb sdc sdd; do
for disk in sda; do
	fdisk -lu /dev/$disk            > fdisk/$disk.txt
	dd if=/dev/$disk bs=512 count=1 > fdisk/$disk.bin 2> /dev/null
done
tar cf fdisk.tar fdisk
rm -fr fdisk

find . \( -name \*.tar -o -name \*.txt \) -print0 | xargs -0 -n1 -P4 -- xz -9
find . -type f -print0 | xargs -0 -n1 -P4 -- gpg2 --encrypt --recipient "Rich Russon (backup) <rich@flatcap.org>"
find . ! -name \*.gpg -delete

chown flatcap:flatcap -R .
chmod 400 *
chmod 500 .

