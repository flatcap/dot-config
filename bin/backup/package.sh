#!/bin/bash

PATH="/usr/bin:/usr/sbin"

[ -n "$1" ] || exit 1

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

DATE=$(date "+%Y-%m-%d")
RCPT="Rich Russon (backup) <rich@flatcap.org>"

for DIR in "$@"; do
	DIR="${DIR%/}"

	if [ ! -d "$DIR" ]; then
		echo "Not a directory: $DIR"
		continue
	fi

	TAR="${DATE}_$DIR.tar.xz.gpg"

	find "$DIR" ! -type d ! -path "*/.git*" -print0					\
		| sort --zero-terminated						\
		| tar --create --file - --null --files-from - --sparse --selinux --acls	\
		| xz --best								\
		| gpg2 --encrypt --recipient "$RCPT" --output "$TAR"

	echo "$TAR"
done

