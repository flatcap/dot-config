#!/bin/bash

STATE=$(xrandr -q | grep -o "current [^,]\+")

if [ "$STATE" = 'current 1440 x 900' ]; then
	xrandr -o right
else
	xrandr -o normal
fi

