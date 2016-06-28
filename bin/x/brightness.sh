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
	local BRIGHT

	BRIGHT=$(xbacklight -get)
	echo ${BRIGHT%.*}
}

function set_brightness()
{
	[ $# = 1 ] || return 1
	valid_percentage "$1" || return 1

	xbacklight -set $1 >& /dev/null
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

function default_jump()
{
	[ $# = 1 ] || echo 1

	local BRIGHT="$1"

	[ $BRIGHT -lt 15 ] && echo 1 && return
	[ $BRIGHT -lt 30 ] && echo 2 && return
	[ $BRIGHT -lt 60 ] && echo 4 && return

	echo 6
}

function calc()
{
	echo "$@" | bc | cut -d. -f1
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
		[ -z "$ADD" ] && ADD=$(default_jump $BRIGHT)
		numeric "$ADD" || usage_quit "Invalid increase: $1"
		BRIGHT=$(calc $BRIGHT+$ADD)
		echo $BRIGHT
		[ $BRIGHT -gt 100 ] && BRIGHT=100
		set_brightness "$BRIGHT"
		NEW=$(get_brightness)
		[ $NEW -le $BRIGHT ] && set_brightness $(calc $BRIGHT+1)
		;;
	-*)
		BRIGHT=$(get_brightness)
		SUB="${1:1:99}"
		[ -z "$SUB" ] && SUB=$(default_jump $BRIGHT)
		numeric "$SUB" || usage_quit "Invalid decrease: $1"
		BRIGHT=$(calc $BRIGHT-$SUB)
		echo $BRIGHT
		[ $BRIGHT -lt 0 ] && BRIGHT=0
		set_brightness "$BRIGHT"
		NEW=$(get_brightness)
		[ $NEW -ge $BRIGHT ] && set_brightness $(calc $BRIGHT-1)
		;;
	[0-9]*)
		set_brightness "$1" || usage_quit "Invalid brightness: $1"
		;;
	*)
		usage_quit
		;;
esac

