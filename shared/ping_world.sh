#!/bin/bash
# Todo
#     log output to a file
#     create an html output file in a shared dir

LOGFILE="/mnt/data/status/internet.txt"
HOST="8.8.8.8"
SLEEP="57s"

get_date()
{
	set -- $(date "+%Y %m %d %H %M %A %B")
	YEAR=$1
	MONTH=$2
	DAY=$3
	HOUR=$4
	MINUTE=$5
}

log_text()
{
	printf "$@" | tee -a "$LOGFILE"
}

log_ping()
{
	if [ $1 = 0 ]; then
		echo -en "\e[32m"		# Good ping - green _
		log_text "_"
	else
		echo -en "\e[31m"		# Bad ping - red X
		log_text "X"
	fi
	echo -en "\e[0m"
}


mkdir -p "${LOGFILE%/*}"

get_date
OLD_HOUR=$HOUR
OLD_DAY=$DAY

[ -f "$LOGFILE" ] && log_text "\n"
log_text "\n$YEAR/$MONTH/$DAY\n$HOUR:$MINUTE "
chmod 644 "$LOGFILE"
chcon -t public_content_t "$LOGFILE"

while :; do
	get_date
	if [ $OLD_DAY != $DAY ]; then
		log_text "\n\n$YEAR/$MONTH/$DAY"
		OLD_DAY=$DAY
	fi

	if [ $OLD_HOUR != $HOUR ]; then
		log_text "\n$HOUR:$MINUTE "
		OLD_HOUR=$HOUR
	fi

	ping -c1 -n $HOST > /dev/null
	log_ping $?

	sleep $SLEEP
done

