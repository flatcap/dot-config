#!/bin/bash

PATH="/usr/bin:/usr/sbin"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

DATE=$(date "+%Y-%m-%d")
RCPT="Rich Russon (backup) <rich@flatcap.org>"
DIR="/backup/$DATE"
GIT_TAR="/backup/${DATE}_git.tar"
TAR_OPTS="--warning=no-file-changed --exclude .git* --exclude .ssh/*@* --exclude shell/vim/backup --exclude shell/vim/swap --exclude shell/vim/undo"

mkdir --parents $DIR

# Run fsck and garbage collection on the git repos
su - gitolite -c "./g tidy >& /dev/null"

cd /var/lib

tar $TAR_OPTS --create --file "$GIT_TAR" gitolite

cd /

tar $TAR_OPTS --create --file $DIR/cron.tar				var/spool/cron
tar $TAR_OPTS --create --file $DIR/etc.tar   				etc
tar $TAR_OPTS --create --file $DIR/mysql.tar --exclude mysql.sock	var/lib/mysql
tar $TAR_OPTS --create --file $DIR/root.tar  				root
tar $TAR_OPTS --create --file $DIR/usr_local.tar			usr/local
tar $TAR_OPTS --create --file $DIR/var_log.tar				var/log
tar $TAR_OPTS --create --file $DIR/www.tar				var/www

tar $TAR_OPTS --create --file $DIR/home.tar	\
	--exclude home/flatcap/torrent		\
	--exclude home/flatcap/books		\
	--exclude home/flatcap/hikes		\
	--exclude home/flatcap/www		\
	home

rpm --query --all | sort > $DIR/rpm_list
rpm --query --all --last > $DIR/rpm_last

cd /backup

xz -6 -T0 *.tar $DIR/*.tar

for i in *.tar.xz $DIR/*; do
	gpg2 --encrypt --recipient "$RCPT" "$i"
	rm "$i"
done

chmod --silent 400 $DIR/* *.gpg
chmod --silent 500 $DIR

chattr +i $DIR/* $DIR *.gpg

