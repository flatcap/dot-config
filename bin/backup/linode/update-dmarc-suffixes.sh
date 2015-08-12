#!/bin/bash
# Get latest effective_tld_names for OpenDMARC

PATH="/usr/bin:/usr/sbin"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0022

cd /etc/opendmarc

wget --no-check-certificate -q -N https://publicsuffix.org/list/effective_tld_names.dat

