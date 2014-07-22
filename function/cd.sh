
function git_branch()
{
	[ -n "$1" ] || return

	git branch 2> /dev/null | grep -Fqw "$1"
}

function cd ()
{
	local LS=""
	if [ -n "$1" ]; then
		if [ -f "$1" ]; then
			set -- "${1%/*}"
		else
			local GDIR="$1"
			[ "$GDIR" = "." ] && GDIR="master"

			if git_branch "$GDIR"; then
				git checkout -q "$GDIR"
				export IGNOREEOF=999
				return
			fi
			local DIR=${1%/*}
			local END=${1##*/}
			if [ "$1" = "." ]; then
				set -- "$(pwd -P)"
			fi
			if [ -d "$DIR" -a "$END" = "ls" ]; then
				set -- "$DIR"
				LS="yes"
			fi
		fi
	else
		[ -n "$CDDIR" ] && set -- "$CDDIR"
	fi
	command cd "$@" > /dev/null 2>&1
	RES=$?
	[ "$LS" = "yes" ] && ls --group-directories-first -lL -T 0 --color=auto -I .\*swp -I lost+found
	return $RES
}

function cddir ()
{
	[ -n "$1" ] && cd "$1"
	CDDIR=$(pwd -P)
	export IGNOREEOF=999
}
