#!/bin/bash

case $1 in
	on|1|true|yes)
		cp /root/iptables.vnc/iptables /etc/sysconfig
		service iptables restart > /dev/null
		;;
	off|0|false|no)
		cp /root/iptables.novnc/iptables /etc/sysconfig
		service iptables restart > /dev/null
		;;
	*)
		;;
esac

diff -q /root/iptables.vnc/iptables /etc/sysconfig/iptables > /dev/null
if [ $? = 0 ]; then
	echo vnc is enabled
else
	echo vnc is disabled
fi

