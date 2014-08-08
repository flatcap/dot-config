
function git_branch()
{
	[ -n "$1" ] || return

	git branch 2> /dev/null | grep -Fqw "$1"
}

function cd ()
{
	local LS=""
	if [ -n "$1" ]; then						# Argument to cd
		if [ -f "$1" ]; then
			set -- "${1%/*}"				# cd dir/file
		else
			if [ -d "$1" ]; then 				# directory exists
				set -- "$1"
			else						# no dir, check for git branch
				local GDIR="$1"
				[ "$GDIR" = "." ] && GDIR="master"	# dir=. => master branch

				if git_branch "$GDIR"; then		# git branch exists => checkout branch
					local GDIR="$1"
					git checkout -q "$GDIR"
					export IGNOREEOF=999
					return
				fi
				local DIR=${1%/*}
				local END=${1##*/}
				if [ "$1" = "." ]; then			# cd . => change to hard directory
					set -- "$(pwd -P)"
				fi
				if [ -d "$DIR" -a "$END" = "ls" ]; then	# cd dirls => cd dir; ls
					set -- "$DIR"
					LS="yes"
				fi
			fi
		fi
	else								# No argument to cd
		[ -n "$CDDIR" ] && set -- "$CDDIR"
	fi
	builtin cd "$@" > /dev/null 2>&1
	RES=$?
	[ "$LS" = "yes" ] && ls --group-directories-first -lL -T 0 --color=auto -I .\*swp -I lost+found
	return $RES
}

function cddir ()
{
	[ -n "$1" ] && builtin cd "$1"
	CDDIR=$(pwd -P)
	export IGNOREEOF=999
}
