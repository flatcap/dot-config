#!/bin/bash

PATH="/usr/bin:/usr/sbin"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

DATE=$(date "+%Y_%m_%d")
RCPT="Rich Russon (backup) <rich@flatcap.org>"
DIR="/backup/$DATE"
TAR_OPTS="--warning=no-file-changed"

mkdir --parents $DIR

cd /var/lib

tar $TAR_OPTS --create --file $DIR/git.tar gitolite

cd /

tar $TAR_OPTS --create --file $DIR/cron.tar				var/spool/cron
tar $TAR_OPTS --create --file $DIR/etc.tar				etc
tar $TAR_OPTS --create --file $DIR/mysql.tar --exclude mysql.sock var/lib/mysql
tar $TAR_OPTS --create --file $DIR/root.tar  --exclude .ssh/*@*		root
tar $TAR_OPTS --create --file $DIR/usr_local.tar			usr/local
tar $TAR_OPTS --create --file $DIR/var_log.tar				var/log
tar $TAR_OPTS --create --file $DIR/www.tar				var/www

tar $TAR_OPTS --create --file $DIR/home.tar
	--exclude home/flatcap/torrent	\
	--exclude home/flatcap/books	\
	--exclude home/flatcap/hikes	\
	--exclude home/flatcap/www	\
	--exclude home/flatcap/.ssh/*@* \
	home

rpm --query --all | sort > $DIR/rpm_list
rpm --query --all --last > $DIR/rpm_last

xz -6 -T0 $DIR/*.tar

cd $DIR

for i in *; do
	gpg2 --encrypt --recipient "$RCPT" $i
	rm $i
done

chmod --silent 400 $DIR/*
chmod --silent 500 $DIR

chattr +i $DIR/* $DIR

