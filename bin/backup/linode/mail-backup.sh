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
TAR_OPTS="--warning=no-file-changed"

mkdir --parents $DIR

cd /

tar $TAR_OPTS --create --file $DIR/mail.tar home/flatcap-mail

cd "$DIR"

xz -9 -T0 *.tar

for i in *.tar.xz; do
	gpg2 --encrypt --recipient "$RCPT" "$i"
	rm "$i"
done

