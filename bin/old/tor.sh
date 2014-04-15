#!/bin/bash

case $1 in
	on|1|true|yes|start)
		service privoxy start > /dev/null
		service tor start > /dev/null
		;;
	off|0|false|no|stop)
		service tor stop > /dev/null
		service privoxy stop > /dev/null
		;;
	*)
		;;
esac

service tor status > /dev/null
TOR=$?
service privoxy status > /dev/null
PRIVOXY=$?
if [ $TOR = 0 -a $PRIVOXY = 0 ]; then
	echo tor is enabled
else
	echo tor is disabled
fi
