function big()
{
	shopt -s nullglob

	local DIR
	local LINES
	for i in "$@"; do
		if [[ "$i" =~ ^[0-9]+$ ]]; then
			LINES="$i"
		elif [ -d "$i" ]; then
			DIR="$i"
		else
			echo "Unknown argument: $i"
		fi
	done

	[ -z "$LINES" ] && LINES=$(($(tput lines) - 4))

	[ -n "$DIR" ] && pushd "$DIR" >& /dev/null
	local LIST=(* .??*)
	local WORK=()
	local HERE=$(pwd -P)
	HERE="${HERE%/}"
	for i in "${LIST[@]}"; do
		[ -L "$i" ] && continue
		[ -f "$i" -o -d "$i" ] || continue
		[ "${i##*/}" = "lost+found" ] && continue
		grep -q " $HERE/$i " /proc/mounts || WORK+=("$i")
	done
	df -h . | sed 1d
	du --summarize --block-size=1K --one-file-system "${WORK[@]}" | sort --numeric-sort --reverse | head --lines $LINES
	[ -n "$DIR" ] && popd >& /dev/null
}

