#!/bin/bash

PATH="/usr/bin:/usr/sbin"

set -o errexit  # set -e
set -o nounset  # set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

cd /root/system
./g pull > /dev/null

cd /etc
git push --quiet > /dev/null

cd /home/flatcap/git/linode_etc.git2
#chown flatcap.flatcap . -R

