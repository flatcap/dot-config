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
TAR="$DATE.tar"
BAK_DIR="/mnt/backup/mozilla"
MOZ_DIR="$HOME/.mozilla"
TMP_DIR=""

function die()
{
	[ -n "$TMP_DIR" ] && rm --force --recursive "$TMP_DIR"
}

trap die EXIT

# check if firefox is running
PID=$(pidof firefox)
if [ -n "$PID" ]; then
	echo "Firefox is still running"
	exit 1
fi

# copy tree
TMP_DIR=$(mktemp --directory)
cp --archive "$MOZ_DIR" "$TMP_DIR"

# empty cookies
find $TMP_DIR -name "cookies.sqlite" -exec sqlite3 {} "delete from moz_cookies" \;

# vacuum sqlite dbs
find $TMP_DIR -name "*.sqlite" -exec sqlite3 {} "vacuum" \;

# empty cache
find $TMP_DIR -depth -name "Cache" -exec rm -fr {} \;

# other random junk
rm --force --recursive $TMP_DIR/.mozilla/extensions
rm --force             $TMP_DIR/XPC.mfasl
find $TMP_DIR -depth -name "bookmarkbackups" -exec rm --force --recursive {} \;
find $TMP_DIR -name "extensions.cache" -exec rm {} \;
find $TMP_DIR -name "*.sqlite-journal" -exec rm {} \;
find $TMP_DIR -name "*.log" -exec rm {} \;

# tar it up
pushd $TMP_DIR > /dev/null
tar --create --file $TAR .mozilla
xz -9 $TAR
chmod 400 $TAR.xz
gpg2 --encrypt --recipient "$RCPT" --output $BAK_DIR/$TAR.xz.gpg $TAR.xz
popd > /dev/null

chmod 400 $BAK_DIR/$TAR.xz.gpg

