function big()
{
	shopt -s nullglob

	local LINES=$(($(tput lines) - 3))
	local LIST=(* .??*)
	local WORK=()
	local HERE=$(pwd -P)
	HERE="${HERE%/}"
	for i in "${LIST[@]}"; do
		[ -L "$i" ] && continue
		[ -f "$i" -o -d "$i" ] || continue
		[ "${i##*/}" = "lost+found" ] && continue
		grep -q " $HERE/$i " /proc/mounts || WORK+=($i)
	done
	du --summarize --block-size=1K --one-file-system "${WORK[@]}" | sort --numeric-sort --reverse | head --lines $LINES
}

