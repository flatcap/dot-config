big()
{
	shopt -s nullglob

	local LINES=$(($(tput lines) - 3))

	du -sm * .??* | sort -nr | head -n $LINES
}

