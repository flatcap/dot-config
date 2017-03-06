#!/bin/bash

PATH="/usr/bin:/usr/sbin"

GIT_ROOT="/home/git/"
GIT_REPO="git-pull:repositories/"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

cd "$GIT_ROOT"

rsync -av "$GIT_REPO" . --delete

