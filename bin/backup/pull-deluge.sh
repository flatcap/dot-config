#!/bin/bash

PATH="/usr/bin:/usr/sbin"

DELUGE_ROOT="/mnt/space/torrent/"
DELUGE_REPO="deluge-pull:torrent/"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

cd "$DELUGE_ROOT"

rsync -av "$DELUGE_REPO" .

