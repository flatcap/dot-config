#!/bin/bash

COORDS="$(xdotool getmouselocation 2> /dev/null)"

X=$(sed 's/^x:\([0-9]\+\).*/\1/'  <<< "$COORDS")
Y=$(sed 's/.*y:\([0-9]\+\).*/\1/' <<< "$COORDS")

#if [ $X -lt 1366 ]; then
#	xdotool mousemove 1500 50
#else
#	xdotool mousemove 1300 50
#fi

# # Dual monitors
# if [ $X -lt 1920 ]; then
# 	xdotool mousemove 2054 50
# else
# 	xdotool mousemove 1854 1050
# fi

# Laptop, split windows
if [ $X -lt 683 ]; then
	xdotool mousemove 700 750
else
	xdotool mousemove 660 750
fi

