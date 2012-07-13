#!/bin/bash

COORDS="$(xdotool getmouselocation 2> /dev/null)"

X=$(sed 's/^x:\([0-9]\+\).*/\1/' <<< "$COORDS")
Y=$(sed 's/.*y:\([0-9]\+\).*/\1/' <<< "$COORDS")

if [ $X -lt 1920 ]; then
	xdotool mousemove 2150 880 # 1950 880
else
	xdotool mousemove 1890 1000 #160
fi

#if [ $X -lt 960 ]; then
#	xdotool mousemove 990 1000
#else
#	xdotool mousemove 930 1000
#fi

