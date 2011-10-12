function cd ()
{
	if [ -n "$1" ]; then
		[ -f "$1" ] && set -- "${1%/*}"
	else
		[ -n "$CDDIR" ] && set -- "$CDDIR"
	fi
	command cd "$@" > /dev/null 2>&1
}

function cddir ()
{
	[ -n "$1" ] && cd "$1"
	CDDIR=$(pwd -P)
}
