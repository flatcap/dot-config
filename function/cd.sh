function cd ()
{
	local LS=""
	if [ -n "$1" ]; then
		if [ -f "$1" ]; then
			set -- "${1%/*}"
		else
			local DIR=${1%/*}
			local END=${1##*/}
			if [ -d "$DIR" -a "$END" = "ls" ]; then
				set -- "$DIR"
				LS="yes"
			fi
		fi
	else
		[ -n "$CDDIR" ] && set -- "$CDDIR"
	fi
	command cd "$@" > /dev/null 2>&1
	[ "$LS" = "yes" ] && ls --group-directories-first -lL -T 0 --color=auto -I .\*swp -I lost+found
}

function cddir ()
{
	[ -n "$1" ] && cd "$1"
	CDDIR=$(pwd -P)
}
