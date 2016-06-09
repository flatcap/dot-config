
function su()
{
	local HERE=$(pwd)
	local DASH
	if [ "$1" = "-" ]; then
		DASH="-"
		shift
	else
		[ "$HERE" = "$HOME" ] && DASH="-"
	fi
	exec su $DASH "$@"
}

