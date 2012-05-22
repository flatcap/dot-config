#!/bin/bash

PATH="/usr/bin:/usr/sbin"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

DATE=$(date "+%Y_%m_%d")
RCPT="Rich Russon (backup) <rich@flatcap.org>"
HOME="/home/flatcap"
TMP_DIR="$HOME/dot.$$"
BAK_DIR="/mnt/backup/dot"
DONTDOT="$BAK_DIR/dontdot.txt"
TAR="$BAK_DIR/$DATE.tar.xz"

if [ ! -d $HOME ]; then
	echo "No home"
	exit 1
fi

if [ ! -f $DONTDOT ]; then
	echo "No dontdot.txt"
	exit 1
fi

if [ ! -d $BAK_DIR ]; then
	echo "No backup dir"
	exit 1
fi

if [ -f $TAR ]; then
	echo "Backup already exists"
	exit 1
fi

mkdir -p $TMP_DIR
if [ ! -d $TMP_DIR ]; then
	echo "Can't create tmp dir"
	exit 1
fi

cp -al $HOME/.??* $TMP_DIR

cd $TMP_DIR 2>&1 > /dev/null

if [ $? != 0 ]; then
	echo "Can't cd into: $TMP_DIR"
	exit 1
fi

rm -fr $(cat $DONTDOT)
find . -name "*.sqlite" -exec sqlite3 {} VACUUM \;
find . -type s -delete

tar cfJ $TAR .??*
gpg2 --encrypt --recipient "$RCPT" --output $TAR.gpg $TAR
rm $TAR
chmod 400 $TAR.gpg

rm -fr $TMP_DIR

