#!/bin/bash

PATH="/usr/bin:/usr/sbin"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

cd "${0%/*}"

HTML="http://www.bbc.co.uk/iplayer/episodes/b00lskhg"		# only connect
FILE="list.html"

rm -f "$FILE"

wget -q -O "$FILE" "$HTML"

AVAILABLE=$(grep -o "/iplayer/episode/[^/]\+" "$FILE")

rm -f "$FILE"

[ -n "$AVAILABLE" ] || exit 0

for i in $AVAILABLE; do
	PID=${i##*/}
	echo GET $PID
	ls | grep -q $PID && continue
	get_iplayer --force --modes=best --pid $PID && break
done

