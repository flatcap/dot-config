#!/bin/bash

[ -n "$1" ] || exit 1

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

for i in "$@"; do
	echo $i
	gpg2 -d "$i" > "${i%.gpg}"
done
