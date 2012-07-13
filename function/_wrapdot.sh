_wrapdot()
{
	local PROGRAM="$1"

	shift

	[ $# = 0 ] && set .
	($PROGRAM "$@" &) > /dev/null 2>&1
}

