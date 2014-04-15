#!/bin/bash

case $1 in
	on|1|true|yes|start)
		service vsftpd start > /dev/null
		;;
	off|0|false|no|stop)
		service vsftpd stop > /dev/null
		;;
	*)
		;;
esac

service vsftpd status > /dev/null
if [ $? = 0 ]; then
	echo ftp is enabled
else
	echo ftp is disabled
fi
