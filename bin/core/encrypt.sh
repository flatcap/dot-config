#!/bin/bash

[ -n "$1" ] || exit 1

RCPT="Rich Russon (backup) <rich@flatcap.org>"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

for i in "$@"; do
	[[ "$i" =~ \.(gz|bz2|xz|zip)$ ]] && COMPRESS="--compress-algo none" || COMPRESS=""
	echo $i
	gpg2 --encrypt --hidden-recipient "$RCPT" $COMPRESS "$i"
done

