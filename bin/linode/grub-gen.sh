#!/bin/bash

set -o errexit	# set -e
set -o nounset	# set -u

cd /boot/grub

umask 0022

RPMS=$(rpm -q kernel | sort -rn)
FILE="grub.conf"
LINK="menu.lst"

{
	echo default=0
	echo timeout=0
	echo

	for VER in $RPMS; do
		VER=${VER#kernel-}
		echo "title $VER"
		echo "        root (hd0)"
		echo "        kernel /boot/vmlinuz-${VER} root=/dev/xvda console=tty0 console=hvc0 ro SYSFONT=latarcyrheb-sun16 LANG=en_GB.UTF-8 KEYTABLE=uk"
		echo "        initrd /boot/initramfs-${VER}.img"
		echo
	done
} > "$FILE"

ln -sf "$FILE" "$LINK"
restorecon "$FILE" "$LINK"

