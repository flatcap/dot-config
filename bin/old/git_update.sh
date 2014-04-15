#!/bin/bash

PATH="/root/bin:/usr/bin:/usr/sbin"

set -o errexit  # set -e
set -o nounset  # set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

cd /root/shell
g pull > /dev/null

