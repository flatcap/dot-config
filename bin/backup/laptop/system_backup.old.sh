#!/bin/bash

PATH="/usr/bin:/usr/sbin"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

DATE=$(date "+%Y-%m-%d")
RCPT="Rich Russon (backup) <rich@flatcap.org>"
DIR="/mnt/space/backup/laptop/$DATE"

cd /

mkdir --parents $DIR

tar --create --file $DIR/cron.tar                       var/spool/cron
tar --create --file $DIR/etc.tar                        etc
tar --create --file $DIR/mysql.tar --exclude mysql.sock var/lib/mysql
tar --create --file $DIR/root.tar  --exclude .ssh/*@*   root
#tar --create --file $DIR/usr_local.tar                  usr/local
tar --create --file $DIR/var_log.tar                    var/log
#tar --create --file $DIR/www.tar                        var/www

cd $DIR

rpm --query --all | sort > rpm_list
rpm --query --all --last > rpm_last

mkdir fdisk
for disk in /dev/sda; do
	name=${disk##*/}
	fdisk -lu $disk            > fdisk/$name.txt
	dd if=$disk bs=512 count=1 > fdisk/$name.bin 2> /dev/null
done
vgcfgbackup --file fdisk/lvm.cfg > /dev/null 2>&1
tar --create --file fdisk.tar fdisk
rm --force --recursive fdisk

find . \( -name \*.tar -o -name \*.txt -o -name \*.sql \) -print0 | xargs --null --max-args 1 --max-procs 4 -- xz --best
find . -type f -print0 | xargs --null --max-args 1 --max-procs 4 -- gpg2 --encrypt --recipient "$RCPT"
find . ! -name "*.gpg" -delete

chown --recursive flatcap:flatcap .
chmod --silent 400 *
chmod --silent 500 .
chattr +i -R .

