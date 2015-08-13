big()
{
	shopt -s nullglob

	local LINES=$(($(tput lines) - 3))

	du -sk * .??* | sort -nr | head -n $LINES
}

