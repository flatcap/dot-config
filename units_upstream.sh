#!/bin/bash

PATH="/usr/bin:/usr/sbin"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

DIR="upstream"

DATE=$(date "+%Y_%m_%d")
RCPT="Rich Russon (backup) <rich@flatcap.org>"
TAR="${DATE}_$DIR.tar.gpg"

cd /home/units

[ -f "$TAR" ] && exit 1

getfacl --recursive "$DIR" > "$DIR.acl"

find "$DIR.acl" "$DIR" -type f -print0						\
	| sort --zero-terminated						\
	| tar --create --file - --null --files-from - --sparse --selinux --acls	\
	| gpg2 --encrypt --recipient "$RCPT" --output "$TAR"

rm -f "$DIR.acl"
chmod --silent 400 "$TAR"

