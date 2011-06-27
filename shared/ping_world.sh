#!/bin/bash
# Todo
#     log output to a file
#     create an html output file in a shared dir

get_date()
{
	set -- $(date "+%Y %m %d %H %M %A %B")
	YEAR=$1
	MONTH=$2
	DAY=$3
	HOUR=$4
	MINUTE=$5
}


HOST="8.8.8.8"
SLEEP="55s"

get_date
OLD_HOUR=$HOUR
OLD_DAY=$DAY

echo "$YEAR/$MONTH/$DAY"
echo -n "$HOUR:$MINUTE "

while :; do
	get_date
	if [ $OLD_DAY != $DAY ]; then
		echo -ne "\n\n$YEAR/$MONTH/$DAY"
		OLD_DAY=$DAY
	fi

	if [ $OLD_HOUR != $HOUR ]; then
		echo -ne "\n$HOUR:$MINUTE "
		OLD_HOUR=$HOUR
	fi

	ping -c1 -n $HOST > /dev/null
	if [ $? = 0 ]; then
		echo -en "\e[32mX\e[0m"		# Good ping - green X
	else
		echo -en "\e[31mX\e[0m"		# Bad ping - red X
	fi
	sleep $SLEEP
done

