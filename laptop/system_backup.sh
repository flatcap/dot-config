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
TAR_OPTS="--warning=no-file-changed --exclude .git* --exclude .ssh/*@* --exclude shell/vim/backup --exclude shell/vim/swap --exclude shell/vim/undo"

cd /

mkdir --parents $DIR

tar $TAR_OPTS --create --file $DIR/cron.tar                       var/spool/cron
tar $TAR_OPTS --create --file $DIR/etc.tar                        etc
tar $TAR_OPTS --create --file $DIR/mysql.tar --exclude mysql.sock var/lib/mysql
tar $TAR_OPTS --create --file $DIR/root.tar                       root
#tar $TAR_OPTS --create --file $DIR/usr_local.tar                  usr/local
tar $TAR_OPTS --create --file $DIR/var_log.tar                    var/log
#tar $TAR_OPTS --create --file $DIR/www.tar                        var/www

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

