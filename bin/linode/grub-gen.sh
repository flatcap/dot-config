#!/bin/bash

set -o errexit	# set -e
set -o nounset	# set -u

cd /boot/
rm -f *rescue*

umask 0022

grub2-mkconfig -o /boot/grub2/grub.cfg >& /dev/null

