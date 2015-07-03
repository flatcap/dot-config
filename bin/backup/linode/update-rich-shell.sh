#!/bin/bash

PATH="/usr/bin:/usr/share/rich-shell/bash/bin/git"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0022

cd /usr/share/rich-shell

gr pull >& /dev/null
gr tidy >& /dev/null

