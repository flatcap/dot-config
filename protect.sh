#!/bin/bash

WORK_DIR="/mnt/backup"
DIRS="config dot eee flatcap linode mozilla root system units"
OWNER="flatcap.flatcap"
MODE="a-w,og-rx"

cd $WORK_DIR 2> /dev/null
[ $? = 0 ] || exit 1

for d in $DIRS; do
	chown --quiet --recursive $OWNER $d
	find $d -type f -print0 | xargs -0 chmod --quiet --recursive $MODE
	find $d -type f -print0 | xargs -0 chattr +i
done

