#!/bin/bash

[ -n "$1" ] || exit 1

RCPT="Rich Russon (backup) <rich@flatcap.org>"

for i in "$@"; do
	echo $i
	gpg2 -e -R "$RCPT" "$i"
done
