#!/bin/bash

PATH="/usr/bin:/usr/sbin"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

cd /var/log/audit

FILES=$(find . -name \*.[0-9])

[ -z "$FILES" ] && exit 0

for i in $FILES; do
	DATE=$(stat --format "%y" "$i")
	DATE=${DATE:0:10}
	FILE="${DATE}_audit.log"
	mv --no-clobber "$i" "$FILE"
	gzip -9 "$FILE"
done

