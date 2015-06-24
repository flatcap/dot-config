#!/bin/bash

COORDS="$(xdotool getmouselocation 2> /dev/null)"

X=$(sed 's/^x:\([0-9]\+\).*/\1/'  <<< "$COORDS")
Y=$(sed 's/.*y:\([0-9]\+\).*/\1/' <<< "$COORDS")

function laptop()
{
	# Laptop: 1366x768
	# ┌──────┬──────┐
	# │      │      │
	# │     .│.     │
	# └──────┴──────┘
	if [ $X -lt 683 ]; then
		xdotool mousemove 700 750
	else
		xdotool mousemove 660 750
	fi
}

function monitor()
{
	# Monitor: 1920x1080
	# ┌──────┬──────┐
	# │      │      │
	# │     .│.     │
	# └──────┴──────┘
	if [ $X -lt 960 ]; then
		xdotool mousemove 977 1064
	else
		xdotool mousemove 943 1064
	fi
}

function monitor_laptop()
{
	# Monitor/Laptop: 3286x1080
	# ┌─────────────┐
	# │             │┌───────┐
	# │            .││.      │
	# └─────────────┘└───────┘
	if [ $X -lt 1920 ]; then
		xdotool mousemove 1940 880
	else
		xdotool mousemove 1854 1050
	fi
}


set -- $(xdotool getdisplaygeometry)

if [ $1 = 1366 ]; then
	laptop
else
	monitor_laptop
fi

