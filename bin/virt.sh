#!/bin/bash

case $1 in
	on|1|true|yes|start)
		service ksm start > /dev/null
		service ksmtuned start > /dev/null
		service libvirtd start > /dev/null
		;;
	off|0|false|no|stop)
		service libvirtd stop > /dev/null
		service ksmtuned stop > /dev/null
		service ksm stop > /dev/null
		;;
	*)
		;;
esac

service libvirtd status > /dev/null
VIRT=$?
service ksmtuned status > /dev/null
KSMT=$?
service ksm status > /dev/null
KSM=$?
if [ $VIRT = 0 -a $KSMT = 0 -a $KSM = 0 ]; then
	echo libvirtd is enabled
else
	echo libvirtd is disabled
fi
