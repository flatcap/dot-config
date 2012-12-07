#!/bin/bash

PATH="/root/bin:/usr/bin:/usr/sbin"

set -o errexit  # set -e
set -o nounset  # set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

function go()
{
	local DIR=$1

	echo "go dir=$DIR"
	[ -n "$DIR" ] || return
}

cd /root/shell
g pull > /dev/null

cd /etc
git push --quiet > /dev/null

cd /home/flatcap/git/linode_etc.git
chown flatcap.flatcap . -R

