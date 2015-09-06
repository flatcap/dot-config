#!/bin/bash

PATH="/usr/bin:/usr/sbin"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

eval DIR=~/torrent/oc
mkdir -p "$DIR"
cd "$DIR"

rsync -a --info=name --min-size 1 s:torrent/Only* .

