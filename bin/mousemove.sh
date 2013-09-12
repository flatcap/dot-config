#!/bin/bash

COORDS="$(xdotool getmouselocation 2> /dev/null)"

X=$(sed 's/^x:\([0-9]\+\).*/\1/'  <<< "$COORDS")
Y=$(sed 's/.*y:\([0-9]\+\).*/\1/' <<< "$COORDS")

if [ $X -lt 1366 ]; then
	xdotool mousemove 1500 50
else
	xdotool mousemove 1300 50
fi

