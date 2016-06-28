title () 
{ 
	local FD
	if [ -t 2 ]; then
		# Use /dev/stderr unless redirected, or
		FD=2
	elif [ -t 1 ]; then
		# Use /dev/stdout unless redirected, or
		FD=1
	else
		# Give up
		return 0
	fi

	local title="";
	case "${1:-}" in 
		"")
			title="${PWD/#$HOME/~}";
		;;
		"-")
		;;
		"done")
			title="done"
		;;
		*)
			title="$*"
		;;
	esac;
	if [ $FD = 2 ]; then
		echo -ne "\033]2;${title}\007" >&2
	else
		echo -ne "\033]2;${title}\007"
	fi
}

export -f title

