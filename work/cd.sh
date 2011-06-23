cd()
{
	if [ -n "$1" ]; then
		[ -f "$1" ] && set -- "${1%/*}"
	else
		[ -n "$CDDIR" ] && set -- "$CDDIR"
	fi
	command cd "$@" > /dev/null 2>&1
}
