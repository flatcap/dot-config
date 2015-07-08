#!/bin/bash

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

echo "Pushing files to google:"
echo

rclone --stats=10s --transfers=1 copy . gdrive:

GDIR="/mnt/space/google"
[ -d "$GDIR" ] || exit

rsync -av . "$GDIR"/

