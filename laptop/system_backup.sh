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

xz -9 *.tar

rpm --query --all | sort > rpm_list
rpm --query --all --last > rpm_last

for i in *; do
	gpg2 --encrypt --recipient "$RCPT" $i
	rm $i
done

chown --recursive flatcap:flatcap .
chmod --silent 400 *
chmod --silent 500 .
chattr +i -R .

