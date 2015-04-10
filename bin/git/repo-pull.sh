#!/bin/bash

PATH="/usr/bin:/usr/sbin:~/.shell/bash/bin/git"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

cd "$HOME/repositories/"

gr pull

