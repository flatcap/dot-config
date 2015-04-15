#!/bin/bash

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

echo "Pulling changes from google:"
echo

cd /mnt/space/google

/mnt/space/bin-extra/rclone --stats=10s copy gdrive: .

