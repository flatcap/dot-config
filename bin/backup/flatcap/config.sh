#!/bin/bash

PATH="/usr/bin:/usr/sbin"
DISPLAY=":0"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

DATE=$(date "+%Y-%m-%d")
RCPT="Rich Russon (backup) <rich@flatcap.org>"
HOME="/home/flatcap"
BAK_DIR="/mnt/space/backup/flatcap/config"
TMP_DIR="$BAK_DIR/$DATE"
TAR="$BAK_DIR/$DATE.tar.xz.gpg"

if [ ! -d $HOME ]; then
	echo "No home"
	exit 1
fi

function die()
{
	[ -n "$TMP_DIR" ] && rm --force --recursive "$TMP_DIR"
}

trap die EXIT

mkdir --parents $TMP_DIR
if [ ! -d $TMP_DIR ]; then
	echo "Can't create tmp dir"
	exit 1
fi

if [ -f "$TAR" ]; then
	echo "Backup already exists"
	exit 1
fi

cd $BAK_DIR 2>&1 > /dev/null

cp --archive $HOME/.config/dconf $TMP_DIR

dconf dump /               > $TMP_DIR/dconf_dump.txt
gsettings list-recursively > $TMP_DIR/dconf_gsettings.txt

find "$DATE" -type f -print0							\
	| sort --zero-terminated						\
	| tar --create --file - --null --files-from - --sparse --selinux --acls	\
	| xz --best									\
	| gpg --encrypt --recipient "$RCPT" --output "$TAR"

rm --force --recursive $TMP_DIR

