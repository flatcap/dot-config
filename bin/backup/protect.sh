#!/bin/bash

PATH="/usr/bin:/usr/sbin"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

WORK_DIR="/home/units/backup"
DIRS="config dot flatcap linode mozilla root system units"
OWNER="flatcap.flatcap"
MODE="a-w,og-rx"

cd $WORK_DIR 2> /dev/null
[ $? = 0 ] || exit 1

for d in $DIRS; do
	chown --quiet --recursive $OWNER $d
	find $d -type f -print0 | xargs --null -- chmod --quiet --recursive $MODE
	find $d -type f -print0 | xargs --null -- chattr +i
done

