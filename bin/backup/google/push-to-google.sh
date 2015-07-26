#!/bin/bash

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

GDIR="/mnt/space/google"
if [ -d "$GDIR" ]; then
	echo "Copying files to $GDIR"
	rsync -av . "$GDIR"/
fi

echo "Pushing files to google:"
echo

rclone --stats=10s --transfers=1 copy . gdrive:

