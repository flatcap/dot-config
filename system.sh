#!/bin/bash

PATH="/usr/bin:/usr/sbin"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

DATE=$(date "+%Y_%m_%d")
RCPT="Rich Russon (backup) <rich@flatcap.org>"
DIR="/mnt/backup/system/$DATE"

cd /

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

mkdir fdisk
#for disk in sda sdb sdc sdd; do
for disk in sda; do
	fdisk -lu /dev/$disk            > fdisk/$disk.txt
	dd if=/dev/$disk bs=512 count=1 > fdisk/$disk.bin 2> /dev/null
done
tar --create --file fdisk.tar fdisk
rm --force --recursive fdisk

find . \( -name \*.tar -o -name \*.txt \) -print0 | xargs --null --max-args 1 --max-procs 4 -- xz -9
find . -type f -print0 | xargs --null --max-args 1 --max-procs 4 -- gpg2 --encrypt --recipient "$RCPT"
find . ! -name "*.gpg" -delete

chown --recursive flatcap:flatcap .
chmod 400 *
chmod 500 .

