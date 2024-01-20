#!/bin/bash

PATH="/usr/bin:/usr/sbin"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

DATE=$(date "+%Y-%m-%d")
RCPT="Rich Russon (backup) <rich@flatcap.org>"
DIR="/backup/linode/$DATE"
TAR_OPTS="--warning=no-file-changed --exclude .git* --exclude .ssh/*@* --exclude .gnupg/S.*"

mkdir --parents $DIR

cd /

tar $TAR_OPTS --create --file $DIR/cron.tar				var/spool/cron
tar $TAR_OPTS --create --file $DIR/etc.tar   --exclude S.gpg-agent	etc
tar $TAR_OPTS --create --file $DIR/mysql.tar --exclude mysql.sock	var/lib/mysql
tar $TAR_OPTS --create --file $DIR/root.tar				root
# tar $TAR_OPTS --create --file $DIR/usr_local.tar			usr/local
tar $TAR_OPTS --create --file $DIR/var_log.tar				var/log
tar $TAR_OPTS --create --file $DIR/www.tar				var/www

tar $TAR_OPTS --create --file $DIR/home.tar	\
	--exclude home/flatcap/torrent		\
	--exclude home/flatcap/.cache		\
	home

rpm --query --all | sort > $DIR/rpm-list
rpm --query --all --last > $DIR/rpm-last

cd "$DIR"

xz -6 -T0 *.tar

for i in *.tar.xz; do
	gpg --encrypt --recipient "$RCPT" "$i"
	rm "$i"
done

