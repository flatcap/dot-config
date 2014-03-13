#!/bin/bash

numeric()
{
	[ $# = 1 ] || return 1

	[[ "$1" =~ ^[0-9]+$ ]]
}

valid_percentage()
{
	[ $# = 1 ] || return 1

	numeric $1 || return 1

	[ "$1" -lt 101 ]
}

function get_brightness()
{
	sudo intel_backlight | sed 's/current backlight value: \([0-9]\+\)%/\1/'
}

function set_brightness()
{
	[ $# = 1 ] || return 1
	valid_percentage "$1" || return 1

	sudo intel_backlight $1 >& /dev/null
	return 0
}

function usage_quit()
{
	[ $# = 1 ] && echo "$1"
	echo
	echo "Usage: ${0##*/} [+|-]{num}"
	echo
	exit 1
}


if [ $# = 0 ]; then
	get_brightness
	exit 0
elif [ $# -gt 1 ]; then
	usage_quit
fi

case "$1" in
	+*)
		BRIGHT=$(get_brightness)
		ADD="${1:1:99}"
		numeric "$ADD" || usage_quit "Invalid increase: $1"
		BRIGHT=$((BRIGHT+ADD))
		[ $BRIGHT -gt 100 ] && BRIGHT=100
		set_brightness "$BRIGHT"
		;;
	-*)
		BRIGHT=$(get_brightness)
		SUB="${1:1:99}"
		numeric "$SUB" || usage_quit "Invalid decrease: $1"
		BRIGHT=$((BRIGHT-SUB))
		[ $BRIGHT -lt 0 ] && BRIGHT=0
		set_brightness "$BRIGHT"
		;;
	[0-9]*)
		set_brightness "$1" || usage_quit "Invalid brightness: $1"
		;;
	*)
		usage_quit
		;;
esac

