_wrapsimple()
{
	local PROGRAM="$1"
	local BASE="$(basename $PROGRAM)"

	shift

	title "$BASE $@"
	$PROGRAM "$@"
	title
}

