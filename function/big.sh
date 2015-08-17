big()
{
	shopt -s nullglob

	local LINES=$(($(tput lines) - 3))

	du --summarize --block-size=1K --one-file-system * .??* | sort --numeric-sort --reverse | head --lines $LINES
}

